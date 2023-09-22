//
//  ConversationsFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public final class ConversationsFactory {
    
    public static func build(navigation: NavigationController) -> ConversationsViewController {
        let viewController = ConversationsViewController()
        let presenter = ConversationsPresenterImpl()
        viewController.presenter = presenter
        return viewController
    }
}
