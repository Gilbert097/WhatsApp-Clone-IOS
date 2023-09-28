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
        let business = MensageBusinessImpl(messageService: messageService, attachmentService: attachmentService)
        
        let imagePickerManager = ImagePickerManager(presentationController: viewController)
        let coordinator = ConversationCoordinatorImpl(navigation: navigation, imagePickerManager: imagePickerManager)
        
        let presenter = ConversationPresenterImpl(view: viewController, coordinator: coordinator, messageBusiness: business, messageManager: manager, conversationUser: user)
        imagePickerManager.delegate = presenter
        viewController.presenter = presenter
        return viewController
    }
}
