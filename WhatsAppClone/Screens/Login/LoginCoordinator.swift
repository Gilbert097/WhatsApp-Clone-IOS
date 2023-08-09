//
//  LoginCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public class LoginCoordinator {
    
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        let viewController = LoginViewController()
        self.navigation.pushViewController(viewController, animated: true)
    }
}
