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
    
    private let coordinator: ConversationCoordinator
    
    public init(coordinator: ConversationCoordinator) {
        self.coordinator = coordinator
    }
    
    public func sendMessageButtonAction(text: String) {
        print("Send button tapped!")
    }
    
}
