//
//  ConversationManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 14/09/23.
//

import Foundation

public protocol ConversationManager {
    func registerChangeListener(conversation: ConversationObserver, listener: @escaping (AddChangeValueResult) -> Void)
    func unregisterChangeListener()
}

class ConversationManagerImpl: ConversationManager {
    
    private let conversationService: ConversationService
    private var registration: DatabaseRegisterListener?
    
    public init(conversationService: ConversationService, registration: DatabaseRegisterListener? = nil) {
        self.conversationService = conversationService
        self.registration = registration
    }
    
    public func registerChangeListener(conversation: ConversationObserver, listener: @escaping (AddChangeValueResult) -> Void)  {
        
        self.registration = self.conversationService.addChangeListener(observer: conversation, completion: listener)
    }
    
    public func unregisterChangeListener() {
        self.registration?.remove()
    }
}
