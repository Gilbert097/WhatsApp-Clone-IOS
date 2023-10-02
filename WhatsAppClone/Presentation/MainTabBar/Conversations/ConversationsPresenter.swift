//
//  ConversationsPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 22/09/23.
//

import Foundation

public protocol ConversationsPresenter {
    var conversations: [ConversationViewModel] { get }
    func start()
    func stop()
}

class ConversationsPresenterImpl: ConversationsPresenter {
    
    private var TAG: String { String(describing: ConversationsPresenterImpl.self) }
    
    public var conversations: [ConversationViewModel] = []
    
    private let view: ConversationsView
    private let manager: ConversationsManager
    
    public init(view: ConversationsView, manager: ConversationsManager) {
        self.view = view
        self.manager = manager
    }
    
    public func start() {
        registerMessageListener()
    }
    
    private func registerMessageListener() {
        guard let currentUser = UserSession.shared.read() else { return }
        let observer = ConversationsObserver(userId: currentUser.id)
        self.manager.registerChangeListener(observer: observer) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let messages):
                let viewModels : [ConversationViewModel] = messages
                    .map({.init(model: $0)})
                self.conversations = viewModels
                self.view.loadList()
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "registerChangeListener error!")
            }
        }
    }
    
    public func stop() {
        self.manager.unregisterChangeListener()
    }
}
