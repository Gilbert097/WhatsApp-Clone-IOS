//
//  MainTabBarCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation

public class MainTabBarCoordinatorImpl: Coordinator {
    
    private let navigation: NavigationController
    
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func show() {
        let tabBarController = MainTabBarFactory.build(navigation: self.navigation)
        self.navigation.pushViewController(tabBarController)
    }
}
