//
//  AuthenticationService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation
import FirebaseAuth

public protocol AuthenticationService {
    func createAuth(request: AuthRequest, completion: @escaping (AutenticationResult) -> Void)
}

public typealias AutenticationResult = Swift.Result<AuthResponse, AuthenticationError>
public class AuthenticationServiceImpl: AuthenticationService {
   
    
    public func createAuth(request: AuthRequest, completion: @escaping (AutenticationResult) -> Void) {
        Auth.auth().createUser(withEmail: request.email, password: request.password) { [weak self] result, error in
            guard let self = self else { return }
            self.handleAutenticationResult(result, error, completion)
        }
    }
    
    private func handleAutenticationResult(_ result: AuthDataResult?,
                                           _ error: Error?,
                                           _ completion: @escaping (AutenticationResult) -> Void) {
        if let result = result {
            let userModel = AuthResponse(user: result.user)
            completion(.success(userModel))
        } else if let error = error {
            guard
                let errorParse = error as NSError?,
                let code = AuthErrorCode.Code(rawValue: errorParse.code)
            else { return completion(.failure(.internalError)) }
            
            switch code {
            case .networkError:
                completion(.failure(.networkError))
            case .userNotFound:
                completion(.failure(.userNotFound))
            case .userTokenExpired:
                completion(.failure(.userTokenExpired))
            case .tooManyRequests:
                completion(.failure(.tooManyRequests))
            case .invalidAPIKey:
                completion(.failure(.invalidAPIKey))
            case .appNotAuthorized:
                completion(.failure(.appNotAuthorized))
            case .keychainError:
                completion(.failure(.keychainError))
            case .internalError:
                completion(.failure(.internalError))
            case .invalidUserToken:
                completion(.failure(.invalidUserToken))
            case .userDisabled:
                completion(.failure(.userDisabled))
            default:
                completion(.failure(.internalError))
            }
        }
    }
}

private extension AuthResponse {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email ?? .init()
        self.name = user.displayName ?? .init()
    }
}
