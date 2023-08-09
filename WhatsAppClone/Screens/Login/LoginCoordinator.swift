//
//  LoginCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public protocol LoginCoordinator: Coordinator {
    func showSignUp()
}

public class LoginCoordinatorImpl: LoginCoordinator  {
    
    private let navigation: NavigationController
    
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func showSignUp() {
        let coordinator = SignUpCoordinatorImpl(navigation: self.navigation)
        coordinator.show()
    }
    
    public func show() {
        let viewController = LoginFactory.build(coordinator: self)
        self.navigation.setRootViewController(viewController)
    }
}
