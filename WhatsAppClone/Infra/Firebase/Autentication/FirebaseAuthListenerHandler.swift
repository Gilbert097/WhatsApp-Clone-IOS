//
//  FirebaseAuthListenerHandler.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation
import FirebaseAuth

class FirebaseAuthListenerHandler: AuthListenerHandler {
    
    public let firebaseHandler: AuthStateDidChangeListenerHandle
    public var description: String
    
    public init(firebaseHandler: AuthStateDidChangeListenerHandle) {
        self.firebaseHandler = firebaseHandler
        self.description = firebaseHandler.description
    }
}
