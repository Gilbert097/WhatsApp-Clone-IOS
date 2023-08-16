//
//  LoginPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation

public protocol LoginPresenter {
    func start()
    func stop()
    func linkButtonAction()
    func loginButtonAction(request: LoginRequest)
}

public class LoginPresenterImpl: LoginPresenter {
    
    private var TAG: String { String(describing: LoginPresenterImpl.self) }
   
    private weak var view: LoginViewController?
    private let coodinator: LoginCoordinator
    private let authService: AuthenticationService
    private let authStateService: AuthenticationStateService
    
    public init(view: LoginViewController?,
                coodinator: LoginCoordinator,
                authService: AuthenticationService,
                authStateService: AuthenticationStateService) {
        self.view = view
        self.coodinator = coodinator
        self.authService = authService
        self.authStateService = authStateService
    }
    
    public func start() {
        authStateService.registerStateDidChangeListener { [weak self] userId in
            guard let self = self else { return }
            if let _ = userId {
                LogUtils.printMessage(tag: self.TAG, message: "Logado")
            } else {
                LogUtils.printMessage(tag: self.TAG, message: "Deslogado")
            }
        }
    }
    
    public func stop() {
        authStateService.removeStateDidChangeListener()
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
            case .success:
                self.coodinator.showMain()
            case .failure:
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar logar!", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
