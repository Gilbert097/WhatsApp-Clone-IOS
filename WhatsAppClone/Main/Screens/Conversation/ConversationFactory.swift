//
//  ConversationFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import Foundation
import UIKit

public final class ConversationFactory {
    
    public static func build(coordinator: ConversationCoordinator, user: UserModel) -> ConversationViewController {
        let viewController = ConversationViewController()
        let firebase = FirebaseFirestoreAdapter()
        let conversationService = ConversationServiceImpl(databaseClient: firebase)
        let presenter = ConversationPresenterImpl(coordinator: coordinator, conversationService: conversationService, conversationUser: user)
        viewController.presenter = presenter
        return viewController
    }
}
