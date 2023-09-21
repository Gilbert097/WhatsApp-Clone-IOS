//
//  ConversationBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 20/09/23.
//

import Foundation

public struct ConversationRequest {
    public let userSender: UserModel
    public let userRecipient: UserModel
    public let text: String?
    public let data: Data?
    
    public func hasData() -> Bool { self.data != nil }
    public func hasText() -> Bool { self.text != nil }
}

public enum ConversationSendMessageError: Error {
    case unexpected
    case updloadAttachment
    case senderUser
    case recipientUser
}

public typealias ConversationSendMessageResult = Swift.Result<Void, ConversationSendMessageError>


public protocol ConversationBusiness {
    func sendMessageFromContentType(request: ConversationRequest, completion: @escaping (ConversationSendMessageResult) -> Void)
}

class ConversationBusinessImpl: ConversationBusiness {
    private var TAG: String { String(describing: ConversationBusinessImpl.self) }
    
    private let messageService: MessageService
    private let attachmentService: MessageAttachmentService
    
    public init(messageService: MessageService, attachmentService: MessageAttachmentService) {
        self.messageService = messageService
        self.attachmentService = attachmentService
    }
    
    public func sendMessageFromContentType(request: ConversationRequest, completion: @escaping (ConversationSendMessageResult) -> Void) {
        if request.hasData() {
            sendAttachmentMenssage(request: request, completion: completion)
        } else if request.hasText() {
            sendTextMenssage(request: request, completion: completion)
        }
    }
    
    private func sendTextMenssage(request: ConversationRequest, completion: @escaping (ConversationSendMessageResult) -> Void) {
        let model = MessageModel(id: UUID().uuidString.lowercased(), userId: request.userSender.id, message: request.text!, urlImage: nil, date: Date())
        self.sendMessageToSenderAndRecipientUser(conversationRequest: request, model: model, completion: completion)
    }
    
    private func sendAttachmentMenssage(request: ConversationRequest, completion: @escaping (ConversationSendMessageResult) -> Void) {
        let messageId = UUID().uuidString.lowercased()
        self.attachmentService.updload(name: messageId, imageData: request.data!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let url):
                let model = MessageModel(id: messageId, userId: request.userSender.id, message: nil, urlImage: url.absoluteString, date: Date())
                self.sendMessageToSenderAndRecipientUser(conversationRequest: request, model: model, completion: completion)
            case .failure:
                completion(.failure(.updloadAttachment))
            }
        }
    }
    
    private func sendMessageToSenderAndRecipientUser(conversationRequest: ConversationRequest,
                                                     model: MessageModel,
                                                     completion: @escaping (ConversationSendMessageResult) -> Void) {
        let group = DispatchGroup()
        
        var senderUserResult: ConversationSendMessageResult!
        group.enter()
        sendMessageToSenderUser(conversationRequest: conversationRequest, model: model, completion: { result in
            senderUserResult = result
            group.leave()
        })
        
        var recipientUserResult: ConversationSendMessageResult!
        group.enter()
        sendMessageToRecipientUser(conversationRequest: conversationRequest, model: model, completion: { result in
            recipientUserResult = result
            group.leave()
        })
        
        group.notify(queue: .main) {
            if case let .failure(error) = senderUserResult {
                completion(.failure(error))
            } else if case let .failure(error) = recipientUserResult {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    private func sendMessageToSenderUser(conversationRequest: ConversationRequest,
                                         model: MessageModel,
                                         completion: @escaping (ConversationSendMessageResult) -> Void) {
        let request = MessageRequest(userSenderId: conversationRequest.userSender.id, userRecipientId: conversationRequest.userRecipient.id, message: model)
        self.messageService.sendMessage(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "SendMessageToSenderUser success!")
                completion(.success(()))
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "SendMessageToSenderUser error!")
                completion(.failure(.senderUser))
            }
        }
    }
    
    private func sendMessageToRecipientUser(conversationRequest: ConversationRequest,
                                            model: MessageModel,
                                            completion: @escaping (ConversationSendMessageResult) -> Void) {
        let request = MessageRequest(userSenderId: conversationRequest.userRecipient.id, userRecipientId: conversationRequest.userSender.id, message: model)
        self.messageService.sendMessage(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "SendMessageToRecipientUser success!")
                completion(.success(()))
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "SendMessageToRecipientUser error!")
                completion(.failure(.recipientUser))
            }
        }
    }
}
