//
//  ConversationBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 20/09/23.
//

import Foundation

public protocol ConversationBusiness {
   
}

class ConversationBusinessImpl: ConversationBusiness {
    private var TAG: String { String(describing: ConversationBusinessImpl.self) }
    
    private let conversationService: ConversationService
    
    public init(conversationService: ConversationService) {
        self.conversationService = conversationService
    }
    
    public func sendMessageToSenderAndRecipientUser(conversationUser: UserModel, conversationMessage: ConversationMessage) {
        guard let currentUser = UserSession.shared.read() else { return }
        let requestUserSender = ConversationRequest(userSenderId: currentUser.id, userRecipientId: conversationUser.id, message: conversationMessage)
        sendMessage(request: requestUserSender)
        let requestUserRecipient = ConversationRequest(userSenderId: conversationUser.id, userRecipientId: currentUser.id, message: conversationMessage)
        sendMessage(request: requestUserRecipient)
    }
    
    private func sendMessage(request: ConversationRequest) {
        self.conversationService.sendMessage(request: request) { [weak self] result in
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
