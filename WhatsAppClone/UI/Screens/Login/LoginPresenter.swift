//
//  LoginPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation

public protocol LoginPresenter {
    func linkButtonAction()
    func loginButtonAction(request: LoginRequest)
}

public class LoginPresenterImpl: LoginPresenter {
   
    private weak var view: LoginViewController?
    private let coodinator: LoginCoordinator
    private let authService: AuthenticationService
    
    public init(view: LoginViewController?, coodinator: LoginCoordinator, authService: AuthenticationService) {
        self.view = view
        self.coodinator = coodinator
        self.authService = authService
    }
    
    public func linkButtonAction() {
        self.coodinator.showSignUp()
    }
    
    public func loginButtonAction(request: LoginRequest) {
        self.view?.display(viewModel: .init(isLoading: true))
        self.authService.signIn(request: .init(email: request.email, password: request.password)) { [weak self] authResult in
            guard let self = self else { return }
            self.view?.display(viewModel: .init(isLoading: false))
            switch authResult {
            case .success(let response):
                self.view?.showMessage(viewModel: .init(title: "Sucesso", message: "Usuário logado com sucesso!\n \(response.uid)", buttons: [.init(title: "Ok")]))
            case .failure:
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar logar!", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
