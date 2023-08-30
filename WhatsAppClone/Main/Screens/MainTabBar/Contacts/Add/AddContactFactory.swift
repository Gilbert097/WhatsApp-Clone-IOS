//
//  AddContactFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 24/08/23.
//

import Foundation

public final class AddContactFactory {
    
    public static func build(navigation: NavigationController) -> AddContactView {
        let viewController = AddContactViewController()
        let coordinator = AddContactCoordinatorImpl(navigation: navigation)
        
        let firebaseFirestore = FirebaseFirestoreAdapter()
        let userService = UserServiceImpl(databaseClient: firebaseFirestore)
        let contactService = ContactServiceImpl(databaseClient: firebaseFirestore)
        let business = ContactsBusinessImpl(userService: userService, contactService: contactService)
        let presenter = AddContactPresenterImpl(view: viewController, coordinator: coordinator, business: business)
        viewController.presenter = presenter
        return viewController
    }
}
