//
//  MainTabBarCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation
import UIKit

public class MainTabBarCoordinatorImpl: Coordinator {
    
    private let navigation: NavigationController
    
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func show() {
        let tabBarViewController = MainTabBarController()
        let conversationsViewController = ConversationsViewController()
        let contactsViewController = ContactsViewController()
        tabBarViewController.setViewControllers([conversationsViewController, contactsViewController], animated: true)
        self.navigation.pushViewController(tabBarViewController)
    }
}
