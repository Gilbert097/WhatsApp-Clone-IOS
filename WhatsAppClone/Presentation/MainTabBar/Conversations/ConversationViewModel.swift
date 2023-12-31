//
//  ConversationViewModel.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public struct ConversationViewModel {
    public let userId: String
    public let name: String
    public let userUrlImage: URL?
    public let lastMessage: String
}

extension ConversationViewModel {
    public init(model: ConversationModel) {
        self.userId = model.userRecipientId
        self.name = model.userRecipientName
        self.userUrlImage = model.userRecipientUrlImage?.toURL()
        self.lastMessage = model.text ?? "Imagem..."
    }
}
