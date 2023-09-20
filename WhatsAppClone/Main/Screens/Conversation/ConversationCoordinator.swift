//
//  ConversationCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import Foundation
import UIKit

public protocol ConversationCoordinator {
    func showImagePicker()
}

class ConversationCoordinatorImpl: ConversationCoordinator  {
    
    private let navigation: NavigationController
    private let imagePickerManager: ImagePickerManager
    
    public init(navigation: NavigationController, imagePickerManager: ImagePickerManager) {
        self.navigation = navigation
        self.imagePickerManager = imagePickerManager
    }
    
    public func showImagePicker() {
        self.imagePickerManager.present()
    }
}
