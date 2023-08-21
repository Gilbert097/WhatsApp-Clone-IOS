//
//  SignUpBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public typealias SignUpResult = Swift.Result<Void, SignUpError>

public protocol SignUpBusiness {
    func signUp(request: SignUpRequest, completion: @escaping (SignUpResult) -> Void)
}

class SignUpBusinessImpl: SignUpBusiness {
    
    private let authService: AuthenticationService
    private let userService: UserService
    
    public init(authService: AuthenticationService, userService: UserService) {
        self.authService = authService
        self.userService = userService
    }
    
    public func signUp(request: SignUpRequest, completion: @escaping (SignUpResult) -> Void) {
        self.authService.createAuth(model: .init(email: request.email, password: request.password)) { [weak self] authResult in
            guard let self = self else { return }
            switch authResult {
            case .success(let response):
                let userModel = UserModel(id: response.uid, name: request.name, email: request.email)
                saveUserInSession(user: .init(model: userModel))
                self.userService.create(model: userModel) { createResult in
                    switch createResult {
                    case .success:
                        completion(.success(()))
                    case .failure:
                        completion(.failure(.createUser))
                    }
                }
            case .failure:
                completion(.failure(.createAuth))
            }
        }
    }
}
