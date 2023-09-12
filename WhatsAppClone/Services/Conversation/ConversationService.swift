//
//  ConversationService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public typealias SendMessageResult = Swift.Result<Void, SendMessageError>

public protocol ConversationService {
    func sendMessage(request: ConversationRequest, completion: @escaping (SendMessageResult) -> Void)
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
}
