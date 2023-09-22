//
//  MainTabBarFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation
import UIKit

public final class MainTabBarFactory {
    
    public static func build(navigation: NavigationController) -> MainTabBarView {
        let tabBarViewController = MainTabBarController()
        let conversations = makeConversationsViewController(navigation: navigation)
        let contacts = makeContactsViewController(navigation: navigation)
        let settings = makeSettingsViewController(navigation: navigation)
        tabBarViewController.setViewControllers([conversations, contacts, settings], animated: true)
        return tabBarViewController
    }
    
    private static func makeConversationsViewController(navigation: NavigationController) -> ConversationsViewController {
        let viewController = ConversationsFactory.build(navigation: navigation)
        viewController.tabBarItem.image = UIImage(named: "conversas")
        viewController.title = "Conversas"
        return viewController
    }
    
    private static func makeContactsViewController(navigation: NavigationController) -> ContactsView {
        let viewController = ContactsFactory.build(navigation: navigation)
        viewController.tabBarItem.image = UIImage(named: "contatos")
        viewController.title = "Contatos"
        return viewController
    }
    
    private static func makeSettingsViewController(navigation: NavigationController) -> SettingsView {
        let viewController = SettingsFactory.build(navigation: navigation)
        viewController.tabBarItem.image = UIImage(named: "ajustes")
        viewController.title = "Ajustes"
        return viewController
    }
}
