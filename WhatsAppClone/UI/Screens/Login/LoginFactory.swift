//
//  LoginFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public final class LoginFactory {
    
    public static func build(coordinator: LoginCoordinator) -> LoginViewController {
        let viewController = LoginViewControllerImpl()
        let authService = AuthenticationServiceImpl()
        let authStateManager = AuthenticationStateManagerImpl()
        let presenter = LoginPresenterImpl(view: viewController,
                                           coodinator: coordinator,
                                           authService: authService,
                                           authStateManager: authStateManager)
        viewController.presenter = presenter
        return viewController
    }
}
