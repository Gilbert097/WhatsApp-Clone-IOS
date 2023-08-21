//
//  DatabaseClientError.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public enum DatabaseClientError: Error {
    case createError
    case updateError
    case valueNotFound
}
