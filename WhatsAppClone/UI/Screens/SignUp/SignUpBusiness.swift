//
//  SignUpBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public typealias SignUpResult = Swift.Result<Void, SignUpError>

public enum SignUpError: Error {
    case createAuth
    case createUser
    case unexpected
}

public protocol SignUpBusiness {
    func signUp(request: SignUpRequest, completion: @escaping (SignUpResult) -> Void)
}

class SignUpBusinessImpl: SignUpBusiness {
    
    private let authService: AuthenticationService
    
    public init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    public func signUp(request: SignUpRequest, completion: @escaping (SignUpResult) -> Void) {
        self.authService.createAuth(model: .init(email: request.email, password: request.password)) { authResult in
            switch authResult {
            case .success(_):
                completion(.success(()))
            case .failure:
                completion(.failure(.createAuth))
            }
        }
    }
    
}
