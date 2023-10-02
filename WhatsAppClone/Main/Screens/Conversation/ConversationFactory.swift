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
        
        let firestore = FirebaseFirestoreAdapter()
        let storage = FirebaseStorageAdapter()
        let manager = MensageManagerImpl(databaseClient: firestore)
        
        let messageService = MessageServiceImpl(databaseClient: firestore)
        let attachmentService = MessageAttachmentServiceImpl(storageClient: storage)
        let messageBusiness = MensageBusinessImpl(messageService: messageService, attachmentService: attachmentService)
        
        let conversationService = ConversationServiceImpl(databaseClient: firestore)
        let conversationBusiness = ConversationBusinessImpl(conversationService: conversationService)
        
        let imagePickerManager = ImagePickerManager(presentationController: viewController)
        let coordinator = ConversationCoordinatorImpl(navigation: navigation, imagePickerManager: imagePickerManager)
        
        let presenter = ConversationPresenterImpl(view: viewController,
                                                  coordinator: coordinator,
                                                  messageBusiness: messageBusiness,
                                                  conversationBusiness: conversationBusiness,
                                                  messageManager: manager,
                                                  conversationUser: user)
        imagePickerManager.delegate = presenter
        viewController.presenter = presenter
        return viewController
    }
}
