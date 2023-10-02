//
//  ConversationService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public typealias SaveConversationResult = Swift.Result<Void, SaveConversationError>

public protocol ConversationService {
    func saveLastConversation(request: ConversationRequest, completion: @escaping (SaveConversationResult) -> Void)
}

class ConversationServiceImpl: ConversationService {
    
    private let databaseClient: DatabaseClient
    
    public init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    public func saveLastConversation(request: ConversationRequest, completion: @escaping (SaveConversationResult) -> Void) {
        let messageItem = DatabaseQueryItem(path: "lastMessage", data: request.model.toData())
        let userRecipientRoot = DatabaseQuery(path: request.userRecipientId, item: messageItem)
        let userSenderItem = DatabaseQueryItem(query: userRecipientRoot, path: request.userSenderId)
        let queryRoot = DatabaseQuery(path: "conversations", item: userSenderItem)
        
        self.databaseClient.create(query: queryRoot) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}

