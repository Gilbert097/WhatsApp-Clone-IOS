//
//  ConversationsCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public protocol ConversationsCoordinator {
    func showConversation(user: UserModel)
}

class ConversationsCoordinatorImpl: ConversationsCoordinator {
    
    private let navigation: NavigationController
   
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func showConversation(user: UserModel) {
        let viewController = ConversationFactory.build(navigation: self.navigation, user: user)
        self.navigation.pushViewController(viewController)
    }
}
