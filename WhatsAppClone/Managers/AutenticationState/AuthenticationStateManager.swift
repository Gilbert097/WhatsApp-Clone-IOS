//
//  AuthenticationStateManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation


import Foundation
import FirebaseAuth

public typealias AuthStateListener = (String?) -> Void

public protocol AuthenticationStateManager {
    func registerStateDidChangeListener(completion: @escaping AuthStateListener)
    func removeStateDidChangeListener()
}

public class AuthenticationStateManagerImpl: AuthenticationStateManager {
    
    private var TAG: String { String(describing: AuthenticationStateManagerImpl.self) }
    private var handler: AuthStateDidChangeListenerHandle?
    
    public func registerStateDidChangeListener(completion: @escaping AuthStateListener) {
        LogUtils.printMessage(tag: TAG, message: "----> Add state did change listener <----")
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] (firAuth, user) in
            guard let self = self else { return }
            LogUtils.printMessage(tag: self.TAG, message: "----> Received state did change <----")
            if let user = user, let email = user.email {
                LogUtils.printMessage(tag: self.TAG, message: "User logged \(email).")
                completion(user.uid)
            } else {
                LogUtils.printMessage(tag: self.TAG, message: "No users logged in!")
                completion(nil)
            }
        }
    }
    
    public func removeStateDidChangeListener() {
        guard let handler = self.handler else { return }
        LogUtils.printMessage(tag: TAG, message: "----> Remove state did change listener <----")
        Auth.auth().removeStateDidChangeListener(handler)
    }
}
