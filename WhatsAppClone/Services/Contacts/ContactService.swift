//
//  ContactService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 25/08/23.
//

import Foundation

public struct ContactRequest {
    public let currentUserId: String
    public let userToAdd: UserModel
}

public typealias AddContactResult = Swift.Result<Void, UserServiceError>

public protocol ContactService {
    func add(request: ContactRequest, completion: @escaping (CreateUserResult) -> Void)
}

class ContactServiceImpl: ContactService {
    
    private let databaseClient: DatabaseClient
    
    public init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    public func add(request: ContactRequest, completion: @escaping (AddContactResult) -> Void) {
        let contactItem = DatabaseQueryItem(path: request.userToAdd.id, data: request.userToAdd.toData())
        let contactsRoot = DatabaseQuery(path: "contacts", item: contactItem)
        let currentUserItem = DatabaseQueryItem(query: contactsRoot, path: request.currentUserId)
        let queryRoot = DatabaseQuery(path: "users", item: currentUserItem)
        
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
