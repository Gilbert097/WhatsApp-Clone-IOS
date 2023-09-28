//
//  ConversationRequest.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public struct MessageRequest {
    public let userSenderId: String
    public let userRecipientId: String
    public let message: MessageModel
    
    public func toString() -> String {
        "\(userSenderId) -> \(userRecipientId)"
    }
}

public struct MessageModel: Model {
    public let id: String
    public let userId: String
    public let message: String?
    public let urlImage: String?
    public let date: Date
    
    public func toURL() -> URL? {
        if let url = urlImage {
            return URL(string: url)
        }
        return nil
    }
}
