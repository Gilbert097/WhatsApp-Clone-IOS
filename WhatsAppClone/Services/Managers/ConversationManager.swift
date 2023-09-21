//
//  ConversationManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 14/09/23.
//

import Foundation

public typealias AddChangeValueResult = Swift.Result<[MessageModel], ConversationError>

public protocol ConversationManager {
    func registerChangeListener(observer: ConversationObserver, listener: @escaping (AddChangeValueResult) -> Void)
    func unregisterChangeListener()
}

class ConversationManagerImpl: ConversationManager {
    
    private let databaseClient: DatabaseClient
    private var registration: DatabaseRegisterListener?
    
    public init(databaseClient: DatabaseClient, registration: DatabaseRegisterListener? = nil) {
        self.databaseClient = databaseClient
        self.registration = registration
    }
    
    public func registerChangeListener(observer: ConversationObserver, listener: @escaping (AddChangeValueResult) -> Void)  {
        
        let userRecipientRoot = DatabaseQuery(path: observer.userRecipientId)
        let userSenderItem = DatabaseQueryItem(query: userRecipientRoot, path: observer.userSenderId)
        let queryRoot = DatabaseQuery(path: "messages", item: userSenderItem)
        
        self.registration = self.databaseClient.addChangeListener(query: queryRoot) { result in
            switch result {
            case .success(let datas):
                let models: [MessageModel] = datas
                    .map({ $0.toModel()})
                    .compactMap({ $0 })
                    .sorted(by: { $0.date.compare($1.date) == .orderedAscending })
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
