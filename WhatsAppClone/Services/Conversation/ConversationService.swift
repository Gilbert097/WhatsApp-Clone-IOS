//
//  ConversationService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public enum ConversationError: Error {
    case unexpected
    case parseError
}

public typealias SendMessageResult = Swift.Result<Void, SendMessageError>
public typealias AddChangeValueResult = Swift.Result<[MessageModel], ConversationError>

public protocol ConversationService {
    func sendMessage(request: ConversationRequest, completion: @escaping (SendMessageResult) -> Void)
    func addChangeListener(observer: ConversationObserver, completion: @escaping (AddChangeValueResult) -> Void) -> DatabaseRegisterListener
}

class ConversationServiceImpl: ConversationService {
    
    private let databaseClient: DatabaseClient
    
    public init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    public func sendMessage(request: ConversationRequest, completion: @escaping (SendMessageResult) -> Void) {
        let messageItem = DatabaseQueryItem(path: request.message.id, data: request.message.toData())
        let userRecipientRoot = DatabaseQuery(path: request.userRecipientId, item: messageItem)
        let userSenderItem = DatabaseQueryItem(query: userRecipientRoot, path: request.userSenderId)
        let queryRoot = DatabaseQuery(path: "messages", item: userSenderItem)
        
        self.databaseClient.create(query: queryRoot) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
    
    public func addChangeListener(observer: ConversationObserver, completion: @escaping (AddChangeValueResult) -> Void) -> DatabaseRegisterListener {
        let userRecipientRoot = DatabaseQuery(path: observer.userRecipientId)
        let userSenderItem = DatabaseQueryItem(query: userRecipientRoot, path: observer.userSenderId)
        let queryRoot = DatabaseQuery(path: "messages", item: userSenderItem)
        
        let registration = self.databaseClient.addChangeListener(query: queryRoot) { result in
            switch result {
            case .success(let datas):
                let models: [MessageModel] = datas
                    .map({ $0.toModel()})
                    .compactMap({ $0 })
                completion(.success(models))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
        return registration
    }
}

public struct ConversationObserver {
    public let userSenderId: String
    public let userRecipientId: String
}

public struct MessageModel: Model {
    public let id: String
    public let message: String
}
