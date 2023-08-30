//
//  LoginPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation

public protocol SignUpPresenter {
    func signUpButtonAction(request: SignUpRequest)
}

public class SignUpPresenterImpl: SignUpPresenter {
   
    private weak var view: SignUpView?
    private let coodinator: SignUpCoordinator
    private let business: SignUpBusiness
    
    public init(view: SignUpView?,
                coodinator: SignUpCoordinator,
                business: SignUpBusiness) {
        self.view = view
        self.coodinator = coodinator
        self.business = business
    }
    
    public func signUpButtonAction(request: SignUpRequest) {
        self.view?.display(viewModel: .init(isLoading: true))
        self.business.signUp(request: request) { [weak self] authResult in
            guard let self = self else { return }
            self.view?.display(viewModel: .init(isLoading: false))
            switch authResult {
            case .success():
                self.coodinator.showMain()
            case .failure:
                self.view?.showMessage(viewModel: .init(title: "Error", message: "Erro ao tentar cadastro!", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
