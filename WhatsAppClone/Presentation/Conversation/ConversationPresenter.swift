//
//  ConversationPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public protocol ConversationPresenter {
    func sendMessageButtonAction(text: String)
}

class ConversationPresenterImpl: ConversationPresenter {
    
    private var TAG: String { String(describing: ConversationPresenterImpl.self) }
    
    private let coordinator: ConversationCoordinator
    private let conversationService: ConversationService
    private let conversationUser: UserModel
    
    public init(coordinator: ConversationCoordinator, conversationService: ConversationService, conversationUser: UserModel) {
        self.coordinator = coordinator
        self.conversationService = conversationService
        self.conversationUser = conversationUser
    }
    
    public func sendMessageButtonAction(text: String) {
        guard let currentUser = UserSession.shared.read() else { return }
        let conversationMessage = ConversationMessage(id: UUID().uuidString.lowercased(), message: text)
        let request = ConversationRequest(userSenderId: currentUser.id, userRecipientId: conversationUser.id, message: conversationMessage)
        self.conversationService.sendMessage(request: request) { [weak self] result in
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
