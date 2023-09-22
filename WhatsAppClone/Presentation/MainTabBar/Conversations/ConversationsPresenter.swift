//
//  ConversationsPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 22/09/23.
//

import Foundation

public struct ConversationViewModel {
    public let name: String
    public let lastMessage: String
}

public protocol ConversationsPresenter {
    var conversations: [ConversationViewModel] { get }
    func start()
}

class ConversationsPresenterImpl: ConversationsPresenter {
    
    public var conversations: [ConversationViewModel] = []
    
    public func start() {
        conversations.append(.init(name: "Gilberto Silva", lastMessage: "Olá"))
        conversations.append(.init(name: "Marina Silva", lastMessage: "Onde você está?"))
    }
}
