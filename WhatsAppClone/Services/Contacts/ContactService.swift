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

public typealias AddContactResult = Swift.Result<Void, ContactServiceError>
public typealias GetAllUserContactsResult = Swift.Result<[UserModel], ContactServiceError>

public protocol ContactService {
    func add(request: ContactRequest, completion: @escaping (AddContactResult) -> Void)
    func getAllUserContacts(user: UserModel, completion: @escaping (GetAllUserContactsResult) -> Void)
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
    
    public func getAllUserContacts(user: UserModel, completion: @escaping (GetAllUserContactsResult) -> Void) {
        let contactsRoot = DatabaseQuery(path: "contacts")
        let currentUserItem = DatabaseQueryItem(query: contactsRoot, path: user.id)
        let queryRoot = DatabaseQuery(path: "users", item: currentUserItem)
        
        self.databaseClient.retrieveValues(query: queryRoot) { result in
            switch result {
            case .success(let datas):
                let models: [UserModel] = datas
                    .map({ $0.toModel()})
                    .compactMap({ $0 })
                completion(.success(models))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
