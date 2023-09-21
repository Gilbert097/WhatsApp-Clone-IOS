//
//  ConversationFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import Foundation
import UIKit

public final class ConversationFactory {
    
    public static func build(navigation: NavigationController, user: UserModel) -> ConversationViewController {
        let viewController = ConversationViewController()
        
        let firebase = FirebaseFirestoreAdapter()
        let conversationService = ConversationServiceImpl(databaseClient: firebase)
        let manager = ConversationManagerImpl(conversationService: conversationService)
        let business = ConversationBusinessImpl(conversationService: conversationService)
        
        let imagePickerManager = ImagePickerManager(presentationController: viewController)
        let coordinator = ConversationCoordinatorImpl(navigation: navigation, imagePickerManager: imagePickerManager)
        
        let presenter = ConversationPresenterImpl(view: viewController, coordinator: coordinator, conversationBusiness: business, conversationManager: manager, conversationUser: user)
        imagePickerManager.delegate = presenter
        viewController.presenter = presenter
        return viewController
    }
}
