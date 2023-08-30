//
//  LoginFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public final class LoginFactory {
    
    public static func build(coordinator: LoginCoordinator) -> LoginView {
        let viewController = LoginViewController()
        
        let firebaseAuth = FirebaseAuthenticationAdapter()
        let authService = AuthenticationServiceImpl(authClient: firebaseAuth)
        let authStateManager = AuthenticationStateManagerImpl(authClient: firebaseAuth)
        
        let firebaseFirestore = FirebaseFirestoreAdapter()
        let userService = UserServiceImpl(databaseClient: firebaseFirestore)
        
        let presenter = LoginPresenterImpl(view: viewController,
                                           coodinator: coordinator,
                                           authService: authService,
                                           userService: userService,
                                           authStateManager: authStateManager)
        viewController.presenter = presenter
        return viewController
    }
}
