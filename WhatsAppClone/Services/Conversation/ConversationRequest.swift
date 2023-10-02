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
    public let userTargetId: String
    public let userTargetName: String
    public let userTargetUrlImage: String?
    public let text: String?
    public let urlImage: String?
    
    public func toURL() -> URL? {
        if let url = urlImage {
            return URL(string: url)
        }
        return nil
    }
}
