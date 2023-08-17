//
//  SettingsPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public protocol SettingsPresenter {
    func logoutButtonAction()
}

public class SettingsPresenterImpl: SettingsPresenter {
    
    private weak var view: SettingsViewController?
    private let authService: AuthenticationService
    private let coordinator: SettingsCoordinator
    
    public init(view: SettingsViewController?, authService: AuthenticationService, coordinator: SettingsCoordinator) {
        self.view = view
        self.authService = authService
        self.coordinator = coordinator
    }
    
    public func logoutButtonAction() {
        self.authService.signOut { [weak self] isSuccess in
            if isSuccess {
                self?.coordinator.backToLogin()
            }
        }
    }
}
