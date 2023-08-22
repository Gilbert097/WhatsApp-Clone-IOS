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
    private let settingsBusiness: SettingsBusiness
    private let coordinator: SettingsCoordinator
    
    public init(view: SettingsViewController?, authService: AuthenticationService, settingsBusiness: SettingsBusiness, coordinator: SettingsCoordinator) {
        self.view = view
        self.authService = authService
        self.settingsBusiness = settingsBusiness
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
        self.view?.showImage(data: data)
        
        self.view?.display(viewModel: .init(isLoading: true))
        self.settingsBusiness.uploadProfilePicture(data: data) { [weak self] result in
            guard let self = self else { return }
            self.view?.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                self.view?.showMessage(viewModel: .init(title: "Successo", message: "Upload da imagem realizado com sucesso!", buttons: [.init(title: "Ok")]))
            case .failure:
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar fazer o upload da imagem.", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
