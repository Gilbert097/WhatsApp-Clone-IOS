//
//  ConversationDetailRequest.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public struct ConversationDetailRequest {
    public let userSender: UserModel
    public let userRecipient: UserModel
    public let text: String?
    public let urlImage: String?
}

extension ConversationDetailRequest {
    
    public func toConversationRequest(target: UserMessageTarget) -> ConversationRequest {
        let conversationId = UUID().uuidString.lowercased()
        switch target {
        case .sender:
            let model = makeSenderConversationModel(id: conversationId)
            return ConversationRequest(userSenderId: userSender.id, userRecipientId: userRecipient.id, model: model)
        case .recipient:
            let model = makeRecipientConversationModel(id: conversationId)
            return ConversationRequest(userSenderId: userRecipient.id, userRecipientId: userSender.id, model: model)
        }
    }
    
    private func makeSenderConversationModel(id: String) -> ConversationModel {
        ConversationModel(
            id: id,
            userRecipientId: userRecipient.id,
            userRecipientName: userRecipient.name,
            userRecipientUrlImage: userRecipient.urlImage,
            userSenderId:  userSender.id,
            text: text,
            urlImage: urlImage
        )
    }
    
    private func makeRecipientConversationModel(id: String) -> ConversationModel {
        ConversationModel(
            id: UUID().uuidString.lowercased(),
            userRecipientId: userSender.id,
            userRecipientName: userSender.name,
            userRecipientUrlImage: userSender.urlImage,
            userSenderId: userSender.id,
            text: text,
            urlImage: urlImage
        )
    }
}
