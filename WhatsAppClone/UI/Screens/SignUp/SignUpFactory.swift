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
        let authService = AuthenticationServiceImpl()
        let presenter = SignUpPresenterImpl(view: viewController,
                                            coodinator: coordinator,
                                            authService: authService)
        viewController.presenter = presenter
        return viewController
    }
}
