//
//  SettingsFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public final class SettingsFactory {
    
    public static func build(navigation: NavigationController) -> SettingsViewController {
        let viewController = SettingsViewControllerImpl()
        
        let firebaseAuth = FirebaseAuthenticationAdapter()
        let authService = AuthenticationServiceImpl(authClient: firebaseAuth)
        
        let firebaseStorage = FirebaseStorageAdapter()
        let profilePictureService = ProfilePictureServiceImpl(storageClient: firebaseStorage)
        
        let firebaseFirestorage = FirebaseFirestoreAdapter()
        let userService = UserServiceImpl(databaseClient: firebaseFirestorage)
        
        let settingsBusiness = SettingsBusinessImpl(profilePictureService: profilePictureService, userService: userService)
        
        let imagePickerManager = ImagePickerManager(presentationController: viewController)
        let coordinator = SettingsCoordinatorImpl(navigation: navigation, imagePickerManager: imagePickerManager)
        
        let presenter = SettingsPresenterImpl(view: viewController,
                                              authService: authService,
                                              settingsBusiness: settingsBusiness,
                                              coordinator: coordinator)
        
        imagePickerManager.delegate = presenter
        viewController.presenter = presenter
        return viewController
    }
}
