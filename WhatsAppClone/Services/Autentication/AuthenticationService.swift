//
//  AuthenticationService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation

public typealias AutenticationResult = Swift.Result<AuthResponse, AuthenticationError>

public protocol AuthenticationService {
    func createAuth(model: AuthModel, completion: @escaping (AutenticationResult) -> Void)
    func signIn(model: AuthModel, completion: @escaping (AutenticationResult) -> Void)
    func signOut(completion: @escaping (Bool) -> Void)
}

public class AuthenticationServiceImpl: AuthenticationService {
    
    private var TAG: String { String(describing: AuthenticationServiceImpl.self) }
    
    private let authClient: AutenticationClient
    
    public init(authClient: AutenticationClient) {
        self.authClient = authClient
    }
    
    public func createAuth(model: AuthModel, completion: @escaping (AutenticationResult) -> Void) {
        self.authClient.createAuth(request: .init(email: model.email, password: model.password)) { [weak self] in
            self?.handleAuthenticationClientResult(result: $0, completion: completion)
        }
    }
    
    public func signIn(model: AuthModel, completion: @escaping (AutenticationResult) -> Void) {
        self.authClient.signIn(request: .init(email: model.email, password: model.password)) { [weak self] in
            self?.handleAuthenticationClientResult(result: $0, completion: completion)
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        self.authClient.signOut(completion: completion)
    }
    
    private func handleAuthenticationClientResult(result: AutenticationClientResult, completion: @escaping (AutenticationResult) -> Void) {
        switch result {
        case .success(let response):
            completion(.success(.init(uid: response.uid)))
        case .failure:
            completion(.failure(.unexpected))
        }
    }
}
