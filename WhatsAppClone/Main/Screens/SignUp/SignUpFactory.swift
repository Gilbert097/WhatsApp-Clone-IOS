//
//  SignUpFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public final class SignUpFactory {
    
    public static func build(coordinator: SignUpCoordinator) -> SignUpViewController {
        let viewController = SignUpViewControllerImpl()
        
        let firebaseAuth = FirebaseAuthenticationAdapter()
        let authService = AuthenticationServiceImpl(authClient: firebaseAuth)
        
        let firebaseFirestore = FirebaseFirestoreAdapter()
        let userService = UserServiceImpl(databaseClient: firebaseFirestore)
        
        let business = SignUpBusinessImpl(authService: authService, userService: userService)
        let presenter = SignUpPresenterImpl(view: viewController,
                                            coodinator: coordinator,
                                            business: business)
        viewController.presenter = presenter
        return viewController
    }
}
