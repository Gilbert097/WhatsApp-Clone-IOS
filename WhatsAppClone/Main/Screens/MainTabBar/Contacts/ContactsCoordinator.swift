//
//  ContactsCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public protocol ContactsCoordinator {
    func showAddContact()
    func showConversation(user: UserModel)
}

class ContactsCoordinatorImpl: ContactsCoordinator {
    
    private let navigation: NavigationController
   
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func showAddContact() {
        let addContactCoordinator = AddContactCoordinatorImpl(navigation: navigation)
        addContactCoordinator.show()
    }
    
    public func showConversation(user: UserModel) {
        let viewController = ConversationFactory.build(navigation: self.navigation, user: user)
        self.navigation.pushViewController(viewController)
    }
}
