//
//  UserSession.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 19/08/23.
//

import Foundation

public struct User: Codable {
    public let id: String
    public let name: String
    public let email: String
}

public struct UserSession {
    
    private static let CURRENT_USER_KEY = "current-user-key"
    
    static let shared = UserSession()
    private init() { }
    
    func save(user: User) -> Bool {
        do {
            let encoder = JSONEncoder()
            let userEncoded = try encoder.encode(user)
            UserDefaults.standard.set(userEncoded, forKey: UserSession.CURRENT_USER_KEY)
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    
    func read() -> User? {
        do {
            if let userRecovered = UserDefaults.standard.value(forKey: UserSession.CURRENT_USER_KEY) as? Data {
                let decoder = JSONDecoder()
                let userDecoded = try decoder.decode(User.self, from: userRecovered) as User
                return userDecoded
            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
}
