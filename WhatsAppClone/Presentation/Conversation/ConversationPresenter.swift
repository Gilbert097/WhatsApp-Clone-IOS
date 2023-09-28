//
//  ConversationPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public protocol ConversationPresenter {
    var messages: [MessageViewModel] { get }
    func start()
    func stop()
    func sendMessageButtonAction(text: String)
    func attachmentButtonAction()
}

class ConversationPresenterImpl: NSObject, ConversationPresenter {
    
    private var TAG: String { String(describing: ConversationPresenterImpl.self) }
    
    private let view: ConversationView
    private let coordinator: ConversationCoordinator
    private let messageBusiness: MensageBusiness
    private let messageManager: MessageManager
    private let conversationUser: UserModel
    
    public var messages: [MessageViewModel] = []
    
    public init(view: ConversationView,
                coordinator: ConversationCoordinator,
                messageBusiness: MensageBusiness,
                messageManager: MessageManager,
                conversationUser: UserModel) {
        self.view = view
        self.coordinator = coordinator
        self.messageBusiness = messageBusiness
        self.messageManager = messageManager
        self.conversationUser = conversationUser
    }
    
    public func start() {
        self.view.setTitle(title: conversationUser.name)
        registerMessageListener()
    }
    
    private func registerMessageListener() {
        guard let currentUser = UserSession.shared.read() else { return }
        let observer = MenssageObserver(userSenderId: currentUser.id, userRecipientId: conversationUser.id)
        self.messageManager.registerChangeListener(observer: observer) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let messages):
                let viewModels : [MessageViewModel] = messages
                    .map({.init(model: $0, isMessageFromCurrentUser: currentUser.id == $0.userId)})
                self.messages = viewModels
                self.view.loadList()
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "registerChangeListener error!")
            }
        }
    }
    
    public func stop() {
        self.messageManager.unregisterChangeListener()
    }
    
    public func sendMessageButtonAction(text: String) {
        guard let request = makeMessageDetailResquest(text: text) else { return }
        self.messageBusiness.sendMessageFromContentType(request: request, completion: { _ in })
    }
    
    private func makeMessageDetailResquest(text: String? = nil, data: Data? = nil) -> MessageDetailRequest? {
        guard let currentUser = UserSession.shared.read() else { return nil}
        return MessageDetailRequest(userSender: .init(userApp: currentUser), userRecipient: self.conversationUser, text: text, data: data)
    }
    
    public func attachmentButtonAction() {
        self.coordinator.showImagePicker()
    }
}

// MARK: - ImagePickerDelegate
extension ConversationPresenterImpl: ImagePickerDelegate {
    
    func didSelect(data: Data) {
        guard let request = makeMessageDetailResquest(data: data) else { return }
        self.messageBusiness.sendMessageFromContentType(request: request, completion: { _ in })
    }
}
