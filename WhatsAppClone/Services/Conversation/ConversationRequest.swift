//
//  ConversationRequest.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public struct ConversationRequest {
    public let userSenderId: String
    public let userRecipientId: String
    public let model: ConversationModel
    
    public func toString() -> String {
        "\(userSenderId) -> \(userRecipientId)"
    }
}

public struct ConversationModel: Model {
    public let id: String
    public let userRecipientId: String
    public let userRecipientName: String
    public let userRecipientUrlImage: String?
    public let userSenderId: String
    public let text: String?
    public let urlImage: String?
    
    public func toString() -> String {
        "id: \(self.id), userRecipientId: \(self.userRecipientId), userRecipientName: \(self.userRecipientName), text: \(self.text ?? .init()), urlImage: \(self.urlImage ?? .init())"
    }
}


