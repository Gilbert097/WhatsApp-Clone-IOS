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
        let conversations = makeConversationsViewController()
        let contacts = makeContactsViewController()
        let settings = makeSettingsViewController()
        tabBarViewController.setViewControllers([conversations, contacts, settings], animated: true)
        self.navigation.pushViewController(tabBarViewController)
    }
    
    private func makeConversationsViewController() -> ConversationsViewController {
        let viewController = ConversationsViewController()
        viewController.tabBarItem.image = UIImage(named: "conversas")
        viewController.title = "Conversas"
        return viewController
    }
    
    private func makeContactsViewController() -> ContactsViewController {
        let viewController = ContactsViewController()
        viewController.tabBarItem.image = UIImage(named: "contatos")
        viewController.title = "Contatos"
        return viewController
    }
    
    private func makeSettingsViewController() -> SettingsViewController {
        let viewController = SettingsFactory.build(navigation: self.navigation)
        viewController.tabBarItem.image = UIImage(named: "ajustes")
        viewController.title = "Ajustes"
        return viewController
    }
}
