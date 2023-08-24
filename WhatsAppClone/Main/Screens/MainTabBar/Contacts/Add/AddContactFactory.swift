//
//  AddContactFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 24/08/23.
//

import Foundation

public final class AddContactFactory {
    
    public static func build(navigation: NavigationController) -> AddContactViewController {
        let viewController = AddContactViewControllerImpl()
        let coordinator = AddContactCoordinatorImpl(navigation: navigation)
        let presenter = AddContactPresenterImpl(coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
}