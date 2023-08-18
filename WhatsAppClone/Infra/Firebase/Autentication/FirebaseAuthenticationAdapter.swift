//
//  FirebaseAuthenticationAdapter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation
import FirebaseAuth

public class FirebaseAuthenticationAdapter: AutenticationClient {
    
    private var TAG: String { String(describing: AuthenticationServiceImpl.self) }
    
    public func createAuth(request: AuthClientRequest, completion: @escaping (AutenticationClientResult) -> Void) {
        Auth.auth().createUser(withEmail: request.email, password: request.password) { [weak self] result, error in
            guard let self = self else { return }
            self.handleAutenticationResult(result, error, completion)
        }
    }
    
    public func signIn(request: AuthClientRequest, completion: @escaping (AutenticationClientResult) -> Void) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { [weak self] result, error in
            guard let self = self else { return }
            self.handleAutenticationResult(result, error, completion)
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
            completion(false)
        }
    }
    
    public func registerStateChangeListener(completion: @escaping AuthStateChangeClientListener) -> AuthListenerHandler {
        let handler = Auth.auth().addStateDidChangeListener { (firAuth, user) in
            if let user = user, let email = user.email {
                completion(.init(name: user.uid, email: email))
            } else {
                completion(nil)
            }
        }
        return FirebaseAuthListenerHandler(firebaseHandler: handler)
    }
    
    public func removeStateChangeListener(handler: AuthListenerHandler) {
        guard let handler = handler as? FirebaseAuthListenerHandler else { return }
        Auth.auth().removeStateDidChangeListener(handler.firebaseHandler)
    }
    
    private func handleAutenticationResult(_ result: AuthDataResult?,
                                           _ error: Error?,
                                           _ completion: @escaping (AutenticationClientResult) -> Void) {
        if let result = result {
            let userModel = AuthClientResponse(user: result.user)
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

private extension AuthClientResponse {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email ?? .init()
        self.name = user.displayName ?? .init()
    }
}
