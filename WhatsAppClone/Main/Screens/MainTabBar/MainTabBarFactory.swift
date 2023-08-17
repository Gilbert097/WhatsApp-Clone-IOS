//
//  MainTabBarFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation
import UIKit

public final class MainTabBarFactory {
    
    public static func build(navigation: NavigationController) -> MainTabBarController {
        let tabBarViewController = MainTabBarControllerImpl()
        let conversations = makeConversationsViewController()
        let contacts = makeContactsViewController()
        let settings = makeSettingsViewController(navigation: navigation)
        tabBarViewController.setViewControllers([conversations, contacts, settings], animated: true)
        return tabBarViewController
    }
    
    private static func makeConversationsViewController() -> ConversationsViewController {
        let viewController = ConversationsViewController()
        viewController.tabBarItem.image = UIImage(named: "conversas")
        viewController.title = "Conversas"
        return viewController
    }
    
    private static func makeContactsViewController() -> ContactsViewController {
        let viewController = ContactsViewController()
        viewController.tabBarItem.image = UIImage(named: "contatos")
        viewController.title = "Contatos"
        return viewController
    }
    
    private static func makeSettingsViewController(navigation: NavigationController) -> SettingsViewController {
        let viewController = SettingsFactory.build(navigation: navigation)
        viewController.tabBarItem.image = UIImage(named: "ajustes")
        viewController.title = "Ajustes"
        return viewController
    }
}
