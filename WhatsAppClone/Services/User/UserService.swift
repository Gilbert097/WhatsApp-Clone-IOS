//
//  UserService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public typealias CreateUserResult = Swift.Result<Void, UserServiceError>

public protocol UserService {
    func create(model: UserModel, completion: @escaping (CreateUserResult) -> Void)
}

class UserServiceImpl: UserService {
    
    private let createClient: DatabaseClient
    
    public init(createClient: DatabaseClient) {
        self.createClient = createClient
    }
    
    public func create(model: UserModel, completion: @escaping (CreateUserResult) -> Void) {
        guard let data = model.toData() else { return completion(.failure(.parseError))}
        let query = DatabaseQuery(path: "users", item: model.id, data: data)
        self.createClient.create(query: query) { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
    
}
