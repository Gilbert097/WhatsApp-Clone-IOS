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
    public let message: MessageModel
}

public protocol ConversationBusiness {
    func sendMessageToSenderAndRecipientUser(request: ConversationRequest)
}

class ConversationBusinessImpl: ConversationBusiness {
    private var TAG: String { String(describing: ConversationBusinessImpl.self) }
    
    private let messageService: MessageService
    
    public init(messageService: MessageService) {
        self.messageService = messageService
    }
    
    public func sendMessageToSenderAndRecipientUser(request: ConversationRequest) {
        let requestUserSender = MessageRequest(userSenderId: request.userSender.id, userRecipientId: request.userRecipient.id, message: request.message)
        sendMessage(request: requestUserSender)
        let requestUserRecipient = MessageRequest(userSenderId: request.userRecipient.id, userRecipientId: request.userSender.id, message: request.message)
        sendMessage(request: requestUserRecipient)
    }
    
    private func sendMessage(request: MessageRequest) {
        self.messageService.sendMessage(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "Send message success! \(request.toString())")
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "Send message error! \(request.toString())")
            }
        }
    }
}
