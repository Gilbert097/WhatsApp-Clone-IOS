//
//  AuthenticationStateManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public typealias AuthStateListener = (AuthStateResponse?) -> Void

public struct AuthStateResponse {
    public let userId: String
}

public protocol AuthenticationStateManager {
    func registerStateChangeListener(completion: @escaping AuthStateListener)
    func removeStateChangeListener()
}

public class AuthenticationStateManagerImpl: AuthenticationStateManager {
    
    private var TAG: String { String(describing: AuthenticationStateManagerImpl.self) }
    private let authClient: AutenticationClient
    private var handler: AuthListenerHandler?
    
    public init(authClient: AutenticationClient, handler: AuthListenerHandler? = nil) {
        self.authClient = authClient
        self.handler = handler
    }
    
    public func registerStateChangeListener(completion: @escaping AuthStateListener) {
        LogUtils.printMessage(tag: TAG, message: "----> Add state did change listener <----")
        self.handler = self.authClient.registerStateChangeListener { [weak self] user in
            guard let self = self else { return }
            LogUtils.printMessage(tag: self.TAG, message: "----> Received state did change <----")
            if let user = user {
                LogUtils.printMessage(tag: self.TAG, message: "User logged \(user.email).")
                completion(.init(userId: user.id))
            } else {
                LogUtils.printMessage(tag: self.TAG, message: "No users logged in!")
                completion(nil)
            }
        }
    }
    
    public func removeStateChangeListener() {
        guard let handler = self.handler else { return }
        LogUtils.printMessage(tag: TAG, message: "----> Remove state did change listener <----")
        self.authClient.removeStateChangeListener(handler: handler)
    }
}

