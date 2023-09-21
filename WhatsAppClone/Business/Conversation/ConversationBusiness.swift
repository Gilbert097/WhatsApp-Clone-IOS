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
    //public let message: MessageModel
    public let text: String?
    public let data: Data?
}

public protocol ConversationBusiness {
    func sendMessageToSenderAndRecipientUser(request: ConversationRequest)
}

class ConversationBusinessImpl: ConversationBusiness {
    private var TAG: String { String(describing: ConversationBusinessImpl.self) }
    
    private let messageService: MessageService
    private let attachmentService: MessageAttachmentService
    
    public init(messageService: MessageService, attachmentService: MessageAttachmentService) {
        self.messageService = messageService
        self.attachmentService = attachmentService
    }
    
    public func sendMessageToSenderAndRecipientUser(request: ConversationRequest) {
        
        let messageId = UUID().uuidString.lowercased()
        if let data = request.data {
            self.attachmentService.updload(name: messageId, imageData: data) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let url):
                    let model = MessageModel(id: messageId, userId: request.userSender.id, message: nil, urlImage: url.absoluteString, date: Date())
                    self.sendMessageToSenderUser(conversationRequest: request, model: model)
                    self.sendMessageToRecipientUser(conversationRequest: request, model: model)
                case .failure:
                    break
                }
            }
        } else if let text = request.text {
            let model = MessageModel(id: messageId, userId: request.userSender.id, message: text, urlImage: nil, date: Date())
            self.sendMessageToSenderUser(conversationRequest: request, model: model)
            self.sendMessageToRecipientUser(conversationRequest: request, model: model)
        }
    }
    
    private func sendMessageToSenderUser(conversationRequest: ConversationRequest, model: MessageModel) {
        let request = MessageRequest(userSenderId: conversationRequest.userSender.id, userRecipientId: conversationRequest.userRecipient.id, message: model)
        self.messageService.sendMessage(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "Send message success!")
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "Send message error!")
            }
        }
    }
    
    private func sendMessageToRecipientUser(conversationRequest: ConversationRequest, model: MessageModel) {
        let request = MessageRequest(userSenderId: conversationRequest.userRecipient.id, userRecipientId: conversationRequest.userSender.id, message: model)
        self.messageService.sendMessage(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "Send message success!")
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "Send message error!")
            }
        }
    }
}
