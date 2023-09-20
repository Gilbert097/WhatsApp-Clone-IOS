//
//  ConversationRequest.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 12/09/23.
//

import Foundation

public struct ConversationRequest {
    public let userSenderId: String
    public let userRecipientId: String
    public let message: ConversationMessage
}

public struct ConversationMessage: Model {
    public let id: String
    public let userId: String
    public let message: String
    public let date: Date
}
