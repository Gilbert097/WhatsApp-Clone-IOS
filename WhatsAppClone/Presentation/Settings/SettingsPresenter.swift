//
//  SettingsPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public protocol SettingsPresenter {
    func logoutButtonAction()
    func selectButtonAction()
}

public class SettingsPresenterImpl: NSObject, SettingsPresenter {
    
    private var TAG: String { String(describing: SettingsPresenterImpl.self) }
    
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
    
    public func selectButtonAction() {
        self.coordinator.showImagePicker()
    }
}

// MARK: - ImagePickerDelegate
extension SettingsPresenterImpl: ImagePickerDelegate {
    
    public func didSelect(data: Data) {
        LogUtils.printMessage(tag: TAG, message: "Image selected!")
    }
}
