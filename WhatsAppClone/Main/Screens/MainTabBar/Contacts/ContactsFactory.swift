//
//  ContactsFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public final class ContactsFactory {
    
    public static func build(navigation: NavigationController) -> ContactsViewController {
        let viewController = ContactsViewControllerImpl()
        let coordinator = ContactsCoordinatorImpl(navigation: navigation)
        let presenter = ContactsPresenterImpl(coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
}
