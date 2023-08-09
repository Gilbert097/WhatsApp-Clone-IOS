//
//  SignUpCoordinator.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public protocol SignUpCoordinator: Coordinator {
}

public class SignUpCoordinatorImpl: SignUpCoordinator  {
    
    private let navigation: NavigationController
    
    public init(navigation: NavigationController) {
        self.navigation = navigation
    }
    
    public func show() {
        let viewController = SignUpFactory.build(coordinator: self)
        self.navigation.pushViewController(viewController)
    }
}
