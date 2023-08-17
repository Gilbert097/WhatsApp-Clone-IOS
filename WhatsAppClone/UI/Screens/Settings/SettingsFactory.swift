//
//  SettingsFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public final class SettingsFactory {
    
    public static func build(navigation: NavigationController) -> SettingsViewController {
        let viewController = SettingsViewControllerImpl()
        let authService = AuthenticationServiceImpl()
        let coordinator = SettingsCoordinatorImpl(navigation: navigation)
        let presenter = SettingsPresenterImpl(view: viewController,
                                              authService: authService,
                                              coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
}
