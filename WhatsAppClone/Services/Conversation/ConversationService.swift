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
       
        let userRecipientItem = DatabaseQueryItem(path: request.userRecipientId, data: request.model.toData())
        let lastMessageRoot = DatabaseQuery(path: "lastConversations", item: userRecipientItem)
        let userSenderItem = DatabaseQueryItem(query: lastMessageRoot, path: request.userSenderId)
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

