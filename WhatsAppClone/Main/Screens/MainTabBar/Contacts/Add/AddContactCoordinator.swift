//
//  AddContactCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 24/08/23.
//

import Foundation

public protocol AddContactCoordinator: Coordinator {
    func close()
}

class AddContactCoordinatorImpl: AddContactCoordinator {
    
    private let navigation: NavigationController
    
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func show() {
        let viewController = AddContactFactory.build(navigation: self.navigation)
        self.navigation.pushViewController(viewController)
    }
    
    public func close() {
        self.navigation.popViewController(animated: true)
    }
}
