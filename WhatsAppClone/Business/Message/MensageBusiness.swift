//
//  MensageBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 20/09/23.
//

import Foundation

public typealias SendMessageBusinessResult = Swift.Result<Void, SendMessageBusinessError>

public protocol MensageBusiness {
    func sendMessageFromContentType(request: MessageDetailRequest, completion: @escaping (SendMessageBusinessResult) -> Void)
}

class MensageBusinessImpl: MensageBusiness {
    
    private var TAG: String { String(describing: MensageBusinessImpl.self) }
    
    private let messageService: MessageService
    private let attachmentService: MessageAttachmentService
    
    public init(messageService: MessageService, attachmentService: MessageAttachmentService) {
        self.messageService = messageService
        self.attachmentService = attachmentService
    }
    
    public func sendMessageFromContentType(request: MessageDetailRequest, completion: @escaping (SendMessageBusinessResult) -> Void) {
        if request.hasData() {
            sendAttachmentMenssage(messageDetailRequest: request, completion: completion)
        } else if request.hasText() {
            sendTextMenssage(messageDetailRequest: request, completion: completion)
        }
    }
    
    private func sendTextMenssage(messageDetailRequest: MessageDetailRequest, completion: @escaping (SendMessageBusinessResult) -> Void) {
        let messageId = UUID().uuidString.lowercased()
        let model = MessageModel(id: messageId, userId: messageDetailRequest.userSender.id, message: messageDetailRequest.text!, urlImage: nil, date: Date())
        self.sendMessageToSenderAndRecipientUser(messageDetailRequest: messageDetailRequest, model: model, completion: completion)
    }
    
    private func sendAttachmentMenssage(messageDetailRequest: MessageDetailRequest, completion: @escaping (SendMessageBusinessResult) -> Void) {
        let messageId = UUID().uuidString.lowercased()
        self.attachmentService.updload(name: messageId, imageData: messageDetailRequest.data!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let url):
                let model = MessageModel(id: messageId, userId: messageDetailRequest.userSender.id, message: nil, urlImage: url.absoluteString, date: Date())
                self.sendMessageToSenderAndRecipientUser(messageDetailRequest: messageDetailRequest, model: model, completion: completion)
            case .failure:
                completion(.failure(.updloadAttachment))
            }
        }
    }
    
    private func sendMessageToSenderAndRecipientUser(messageDetailRequest: MessageDetailRequest,
                                                     model: MessageModel,
                                                     completion: @escaping (SendMessageBusinessResult) -> Void) {
        let group = DispatchGroup()
        var senderUserResult: SendMessageBusinessResult!
        let senderUserRequest = messageDetailRequest.toMessageRequest(model: model, target: .sender)
        group.enter()
        sendMessage(messageRequest: senderUserRequest, completion: { result in
            senderUserResult = result
            group.leave()
        })
        
        var recipientUserResult: SendMessageBusinessResult!
        let recipientUserRequest = messageDetailRequest.toMessageRequest(model: model, target: .recipient)
        group.enter()
        sendMessage(messageRequest: recipientUserRequest,  completion: { result in
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
    
    private func sendMessage(messageRequest: MessageRequest,
                             completion: @escaping (SendMessageBusinessResult) -> Void) {
        self.messageService.sendMessage(request: messageRequest) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "SendMessage success!")
                completion(.success(()))
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "SendMessage error!")
                completion(.failure(.senderUser))
            }
        }
    }

}
