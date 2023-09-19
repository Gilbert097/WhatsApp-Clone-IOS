//
//  FirebaseFirestoreListener.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 13/09/23.
//

import Foundation
import FirebaseFirestore

public protocol DatabaseRegisterListener {
    func remove()
}

class FirestoreRegiterListener: DatabaseRegisterListener {
    
    private let registration: ListenerRegistration
    
    public init(registration: ListenerRegistration) {
        self.registration = registration
    }
    
    public func remove() {
        registration.remove()
    }
}
