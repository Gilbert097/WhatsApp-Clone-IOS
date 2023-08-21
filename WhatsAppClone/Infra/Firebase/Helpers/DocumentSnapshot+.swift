//
//  DocumentSnapshot+.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 21/08/23.
//

import Foundation
import FirebaseFirestore

public extension DocumentSnapshot {
    var value: Data? {
        guard let value = data() else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
}
