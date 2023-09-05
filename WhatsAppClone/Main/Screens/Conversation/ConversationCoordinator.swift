//
//  ConversationCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import Foundation
import UIKit

public protocol ConversationCoordinator: Coordinator {
}

public class ConversationCoordinatorImpl: ConversationCoordinator  {
    
    private let navigation: NavigationController
    private let user: UserModel
    
    public init(navigation: NavigationController, user: UserModel) {
        self.navigation = navigation
        self.user = user
    }
    
    public func show() {
        let viewController = ConversationFactory.build(coordinator: self, user: self.user)
        self.navigation.pushViewController(viewController)
    }
}
