//
//  ConversationManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public enum ConversationsError: Error {
    case unexpected
    case parseError
}

public typealias AddChangeConversationsResult = Swift.Result<[ConversationModel], ConversationsError>

public struct ConversationsObserver {
    public let userId: String
}

public protocol ConversationsManager {
    func registerChangeListener(observer: ConversationsObserver, listener: @escaping (AddChangeConversationsResult) -> Void)
    func unregisterChangeListener()
}

class ConversationsManagerImpl: ConversationsManager {
    
    private let databaseClient: DatabaseClient
    private var registration: DatabaseRegisterListener?
    
    public init(databaseClient: DatabaseClient, registration: DatabaseRegisterListener? = nil) {
        self.databaseClient = databaseClient
        self.registration = registration
    }
    
    public func registerChangeListener(observer: ConversationsObserver, listener: @escaping (AddChangeConversationsResult) -> Void)  {
        
        let lasConversationsRoot = DatabaseQuery(path: "lastConversations")
        let userItem = DatabaseQueryItem(query: lasConversationsRoot, path: observer.userId)
        let queryRoot = DatabaseQuery(path: "conversations", item: userItem)
        
        self.registration = self.databaseClient.addChangeListener(query: queryRoot) { result in
            switch result {
            case .success(let datas):
                let models: [ConversationModel] = datas
                    .map({ $0.toModel()})
                    .compactMap({ $0 })
                    .sorted(by: { $0.userTargetName.compare($1.userTargetName) == .orderedAscending })
                listener(.success(models))
            case .failure:
                listener(.failure(.unexpected))
            }
        }
    }
    
    public func unregisterChangeListener() {
        self.registration?.remove()
    }
}
