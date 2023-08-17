//
//  SettingsCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public protocol SettingsCoordinator{
    func backToLogin() 
}

class SettingsCoordinatorImpl: SettingsCoordinator {
    
    private let navigation: NavigationController
    
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func backToLogin() {
        self.navigation.backToViewController(viewController: LoginViewControllerImpl.self)
    }
}
