//
//  ConversationManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public typealias AddChangeConversationResult = Swift.Result<ConversationModel, ConversationsError>

public protocol ConversationEventManager {
    func registerChangeListener(observer: ConversationsObserver, listener: @escaping (AddChangeConversationResult) -> Void)
    func unregisterChangeListener()
}

class ConversationEventManagerImpl: ConversationEventManager {
    
    private let databaseClient: DatabaseClient
    private var registration: DatabaseRegisterListener?
    
    public init(databaseClient: DatabaseClient, registration: DatabaseRegisterListener? = nil) {
        self.databaseClient = databaseClient
        self.registration = registration
    }
    
    public func registerChangeListener(observer: ConversationsObserver, listener: @escaping (AddChangeConversationResult) -> Void)  {
        
        let lasConversationsRoot = DatabaseQuery(path: "lastConversations")
        let userItem = DatabaseQueryItem(query: lasConversationsRoot, path: observer.userId)
        let queryRoot = DatabaseQuery(path: "conversations", item: userItem)
        
        self.registration = self.databaseClient.addChangeListener(query: queryRoot, events: [.added, .updated]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let model: ConversationModel = data.toModel() {
                    listener(.success(model))
                }
            case .failure:
                listener(.failure(.unexpected))
            }
        }
    }
    
    public func unregisterChangeListener() {
        self.registration?.remove()
    }
}
