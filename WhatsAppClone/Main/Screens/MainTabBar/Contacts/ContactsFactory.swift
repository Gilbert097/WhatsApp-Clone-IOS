//
//  ContactsFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public final class ContactsFactory {
    
    public static func build(navigation: NavigationController) -> ContactsView {
        let viewController = ContactsViewController()
        let coordinator = ContactsCoordinatorImpl(navigation: navigation)
        let firebase = FirebaseFirestoreAdapter()
        let contactService = ContactServiceImpl(databaseClient: firebase)
        let presenter = ContactsPresenterImpl(view: viewController, coordinator: coordinator, contactService: contactService)
        viewController.presenter = presenter
        return viewController
    }
}
