//
//  AuthenticationError.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation

public enum AuthenticationError: Error {
    case networkError
    case userNotFound
    case userTokenExpired
    case tooManyRequests
    case invalidAPIKey
    case appNotAuthorized
    case keychainError
    case internalError
    case invalidUserToken
    case userDisabled
}
