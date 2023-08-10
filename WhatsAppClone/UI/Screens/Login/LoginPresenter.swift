//
//  LoginPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation

public protocol LoginPresenter {
    func signUpButtonAction()
}

public class LoginPresenterImpl: LoginPresenter {
   
    private weak var view: LoginViewController?
    private let coodinator: LoginCoordinator
    
    public init(view: LoginViewController?, coodinator: LoginCoordinator) {
        self.view = view
        self.coodinator = coodinator
    }
    
    public func signUpButtonAction() {
        self.coodinator.showSignUp()
    }
}
