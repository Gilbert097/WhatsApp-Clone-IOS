//
//  MessageViewModel.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 25/09/23.
//

import Foundation

public struct MessageViewModel {
    public let message: String?
    public let urlImage: URL?
    public let isMessageFromCurrentUser: Bool
}

extension MessageViewModel {
    
    public init(model: MessageModel, isMessageFromCurrentUser: Bool) {
        self.message = model.message
        self.urlImage = model.toURL()
        self.isMessageFromCurrentUser = isMessageFromCurrentUser
    }
}
