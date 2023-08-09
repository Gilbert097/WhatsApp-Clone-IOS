//
//  SignUpFactory.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation
import UIKit

public final class SignUpFactory {
    
    public static func build(coordinator: SignUpCoordinator) -> SignUpViewController {
        let viewController = SignUpViewControllerImpl()
        let presenter = SignUpPresenterImpl(view: viewController, coodinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
}
