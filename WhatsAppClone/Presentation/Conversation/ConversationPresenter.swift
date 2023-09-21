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
    private let conversationBusiness: ConversationBusiness
    private let conversationManager: ConversationManager
    private let conversationUser: UserModel
    
    public var messages: [MessageViewModel] = []
    
    public init(view: ConversationView,
                coordinator: ConversationCoordinator,
                conversationBusiness: ConversationBusiness,
                conversationManager: ConversationManager,
                conversationUser: UserModel) {
        self.view = view
        self.coordinator = coordinator
        self.conversationBusiness = conversationBusiness
        self.conversationManager = conversationManager
        self.conversationUser = conversationUser
    }
    
    public func start() {
        self.view.setTitle(title: conversationUser.name)
        registerConversationListener()
    }
    
    private func registerConversationListener() {
        guard let currentUser = UserSession.shared.read() else { return }
        let observer = ConversationObserver(userSenderId: currentUser.id, userRecipientId: conversationUser.id)
        self.conversationManager.registerChangeListener(observer: observer) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let messages):
                let viewModels = messages
                    .map({MessageViewModel(message: $0.message, urlImage: $0.toURL(), isMessageFromCurrentUser: currentUser.id == $0.userId)})
                self.messages = viewModels
                self.view.loadList()
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "registerChangeListener error!")
                break
            }
        }
    }
    
    public func stop() {
        self.conversationManager.unregisterChangeListener()
    }
    
    public func sendMessageButtonAction(text: String) {
        guard let request = makeConversationResquest(text: text) else { return }
        self.conversationBusiness.sendMessageFromContentType(request: request, completion: { _ in })
    }
    
    private func makeConversationResquest(text: String? = nil, data: Data? = nil) -> ConversationRequest? {
        guard let currentUser = UserSession.shared.read() else { return nil}
        return ConversationRequest(userSender: .init(userApp: currentUser), userRecipient: self.conversationUser, text: text, data: data)
    }
    
    public func attachmentButtonAction() {
        self.coordinator.showImagePicker()
    }
}

// MARK: - ImagePickerDelegate
extension ConversationPresenterImpl: ImagePickerDelegate {
    
    func didSelect(data: Data) {
        guard let request = makeConversationResquest(data: data) else { return }
        self.conversationBusiness.sendMessageFromContentType(request: request, completion: { _ in })
    }
}

public struct MessageViewModel {
    public let message: String?
    public let urlImage: URL?
    public let isMessageFromCurrentUser: Bool
}
