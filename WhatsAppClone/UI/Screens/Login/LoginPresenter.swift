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
    private let authStateManager: AuthenticationStateManager
    
    public init(view: LoginViewController?,
                coodinator: LoginCoordinator,
                authService: AuthenticationService,
                authStateManager: AuthenticationStateManager) {
        self.view = view
        self.coodinator = coodinator
        self.authService = authService
        self.authStateManager = authStateManager
    }
    
    public func start() {
        authStateManager.registerStateDidChangeListener { [weak self] userId in
            guard let self = self else { return }
            if let _ = userId {
                LogUtils.printMessage(tag: self.TAG, message: "Logado")
                self.coodinator.showMain()
            } else {
                LogUtils.printMessage(tag: self.TAG, message: "Deslogado")
            }
        }
    }
    
    public func stop() {
        authStateManager.removeStateDidChangeListener()
    }
    
    public func linkButtonAction() {
        self.coodinator.showSignUp()
    }
    
    public func loginButtonAction(request: LoginRequest) {
        self.view?.display(viewModel: .init(isLoading: true))
        self.authService.signIn(model: .init(email: request.email, password: request.password)) { [weak self] authResult in
            guard let self = self else { return }
            self.view?.display(viewModel: .init(isLoading: false))
            
            if case .failure = authResult {
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar logar!", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
