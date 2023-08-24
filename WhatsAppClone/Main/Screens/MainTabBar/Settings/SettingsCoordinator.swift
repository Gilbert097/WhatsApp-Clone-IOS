//
//  SettingsCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public protocol SettingsCoordinator {
    func backToLogin()
    func showImagePicker() 
}

class SettingsCoordinatorImpl: SettingsCoordinator {
    
    private let navigation: NavigationController
    private let imagePickerManager: ImagePickerManager
    
    public init(navigation: NavigationController, imagePickerManager: ImagePickerManager) {
        self.navigation = navigation
        self.imagePickerManager = imagePickerManager
    }
    
    public func backToLogin() {
        self.navigation.backToViewController(viewController: LoginViewControllerImpl.self)
    }
    
    public func showImagePicker() {
        self.imagePickerManager.present()
    }
}
