//
//  MessageDetailRequest.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 25/09/23.
//

import Foundation

public enum UserMessageTarget {
    case sender
    case recipient
}

public struct MessageDetailRequest {
    public let userSender: UserModel
    public let userRecipient: UserModel
    public let text: String?
    public let data: Data?
    
    public func hasData() -> Bool { self.data != nil }
    public func hasText() -> Bool { self.text != nil }
}

extension MessageDetailRequest {
    
    public func toMessageRequest(model: MessageModel,
                                 target: UserMessageTarget) -> MessageRequest {
        switch target {
        case .sender:
            return MessageRequest(userSenderId: self.userSender.id, userRecipientId: self.userRecipient.id, message: model)
        case .recipient:
            return MessageRequest(userSenderId: self.userRecipient.id, userRecipientId: self.userSender.id, message: model)
        }
    }
}
