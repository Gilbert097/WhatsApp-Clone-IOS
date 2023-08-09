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
    
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func showSignUp() {
        
    }
    
    public func show() {
        let viewController = LoginFactory.build(coordinator: self)
        self.navigation.pushViewController(viewController, animated: true)
    }
}
