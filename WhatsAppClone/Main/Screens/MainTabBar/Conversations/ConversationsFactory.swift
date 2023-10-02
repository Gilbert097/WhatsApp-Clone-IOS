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
        let firebase = FirebaseFirestoreAdapter()
        let manager = ConversationsManagerImpl(databaseClient: firebase)
        let presenter = ConversationsPresenterImpl(view: viewController, manager: manager)
        viewController.presenter = presenter
        return viewController
    }
}
