//
//  AutenticationClient.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public typealias AuthStateChangeClientListener = (UserAuthClient?) -> Void
public typealias AutenticationClientResult = Swift.Result<AuthClientResponse, AuthenticationClientError>

public protocol AutenticationClient {
    func createAuth(request: AuthClientRequest, completion: @escaping (AutenticationClientResult) -> Void)
    func signIn(request: AuthClientRequest, completion: @escaping (AutenticationClientResult) -> Void)
    func signOut(completion: @escaping (Bool) -> Void)
    func registerStateChangeListener(completion: @escaping AuthStateChangeClientListener) -> AuthListenerHandler
    func removeStateChangeListener(handler: AuthListenerHandler)
}
