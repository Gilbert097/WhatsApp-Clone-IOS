//
//  ConversationManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 14/09/23.
//

import Foundation

public enum MessageError: Error {
    case unexpected
    case parseError
}

public typealias AddChangeMessageResult = Swift.Result<[MessageModel], MessageError>

public struct MenssageObserver {
    public let userSenderId: String
    public let userRecipientId: String
}

public protocol MessageManager {
    func registerChangeListener(observer: MenssageObserver, listener: @escaping (AddChangeMessageResult) -> Void)
    func unregisterChangeListener()
}

class MensageManagerImpl: MessageManager {
    
    private let databaseClient: DatabaseClient
    private var registration: DatabaseRegisterListener?
    
    public init(databaseClient: DatabaseClient, registration: DatabaseRegisterListener? = nil) {
        self.databaseClient = databaseClient
        self.registration = registration
    }
    
    public func registerChangeListener(observer: MenssageObserver, listener: @escaping (AddChangeMessageResult) -> Void)  {
        
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
