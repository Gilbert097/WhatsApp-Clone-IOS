//
//  ConversationPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public protocol ConversationPresenter {
    func start()
    func stop()
    func sendMessageButtonAction(text: String)
}

class ConversationPresenterImpl: ConversationPresenter {
    
    private var TAG: String { String(describing: ConversationPresenterImpl.self) }
    
    private let coordinator: ConversationCoordinator
    private let conversationService: ConversationService
    private let conversationManager: ConversationManager
    private let conversationUser: UserModel
    
    public init(coordinator: ConversationCoordinator,
                conversationService: ConversationService,
                conversationManager: ConversationManager,
                conversationUser: UserModel) {
        self.coordinator = coordinator
        self.conversationService = conversationService
        self.conversationManager = conversationManager
        self.conversationUser = conversationUser
    }
    
    public func start() {
        guard let currentUser = UserSession.shared.read() else { return }
        let conversation = ConversationObserver(userSenderId: currentUser.id, userRecipientId: conversationUser.id)
        self.conversationManager.registerChangeListener(conversation: conversation) { result in
            switch result {
                
            case .success(let messages):
                break
            case .failure:
                break
            }
        }
    }
    
    public func stop() {
        self.conversationManager.unregisterChangeListener()
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
