//
//  LoginPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation

public protocol SignUpPresenter {
    func signUp(request: SignUpRequest)
}

public class SignUpPresenterImpl: SignUpPresenter {
   
    private weak var view: SignUpViewController?
    private let coodinator: SignUpCoordinator
    private let authService: AuthenticationService
    
    public init(view: SignUpViewController?,
                coodinator: SignUpCoordinator,
                authService: AuthenticationService) {
        self.view = view
        self.coodinator = coodinator
        self.authService = authService
    }
    
    public func signUp(request: SignUpRequest) {
        self.view?.display(viewModel: .init(isLoading: true))
        self.authService.createAuth(request: .init(email: request.email, password: request.password)) { [weak self] authResult in
            guard let self = self else { return }
            self.view?.display(viewModel: .init(isLoading: false))
            switch authResult {
            case .success(let response):
                self.view?.showMessage(viewModel: .init(title: "Sucesso", message: "Usuário cadastrado com sucesso!\n \(response.uid)", buttons: [.init(title: "Ok")]))
            case .failure:
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar cadastro!", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
