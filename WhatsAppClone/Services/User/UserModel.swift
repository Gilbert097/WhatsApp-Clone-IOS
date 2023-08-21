//
//  UserModel.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public struct UserModel: Model {
    public let id: String
    public let name: String
    public let email: String
}

public extension UserApp {
    init(model: UserModel) {
        self.id = model.id
        self.name = model.name
        self.email = model.email
    }
}
