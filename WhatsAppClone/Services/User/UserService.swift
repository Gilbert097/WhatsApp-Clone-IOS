//
//  UserService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public typealias CreateUserResult = Swift.Result<Void, UserServiceError>
public typealias RetrieveUserResult = Swift.Result<UserModel, UserServiceError>

public protocol UserService {
    func create(model: UserModel, completion: @escaping (CreateUserResult) -> Void)
    func retrieve(userId: String, completion: @escaping (RetrieveUserResult) -> Void)
}

class UserServiceImpl: UserService {
    
    private let databaseClient: DatabaseClient
    
    public init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    public func create(model: UserModel, completion: @escaping (CreateUserResult) -> Void) {
        guard let data = model.toData() else { return completion(.failure(.parseError))}
        let query = DatabaseQuery(path: "users", item: model.id, data: data)
        self.databaseClient.create(query: query) { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
    
    public func retrieve(userId: String, completion: @escaping (RetrieveUserResult) -> Void) {
        let query = DatabaseQuery(path: "users", item: userId, data: nil)
        self.databaseClient.retrieve(query: query) { result in
            switch result {
            case .success(let data):
                if let model: UserModel = data.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
