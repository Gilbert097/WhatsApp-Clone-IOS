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
        let presenter = ContactsPresenterImpl(coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
}
