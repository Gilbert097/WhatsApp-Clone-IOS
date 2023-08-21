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
    private let userService: UserService
    private let authStateManager: AuthenticationStateManager
    
    public init(view: LoginViewController?,
                coodinator: LoginCoordinator,
                authService: AuthenticationService,
                userService: UserService,
                authStateManager: AuthenticationStateManager) {
        self.view = view
        self.coodinator = coodinator
        self.authService = authService
        self.userService = userService
        self.authStateManager = authStateManager
    }
    
    public func start() {
        authStateManager.registerStateChangeListener { [weak self] response in
            guard let self = self else { return }
            if let userId = response?.userId {
                LogUtils.printMessage(tag: self.TAG, message: "Logado")
                self.retrieveLoggedInUserInformation(userId: userId)
            } else {
                LogUtils.printMessage(tag: self.TAG, message: "Deslogado")
            }
        }
    }
    
    private func retrieveLoggedInUserInformation(userId: String) {
        self.userService.retrieve(userId: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userModel):
                UserSession.shared.save(user: .init(model: userModel))
                self.coodinator.showMain()
            case .failure:
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar recuperar informações do usuário!", buttons: [.init(title: "Ok")]))
            }
        }
    }
    
    public func stop() {
        authStateManager.removeStateChangeListener()
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
