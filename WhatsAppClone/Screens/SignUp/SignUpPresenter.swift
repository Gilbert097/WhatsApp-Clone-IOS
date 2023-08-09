//
//  LoginPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import Foundation

public protocol SignUpPresenter {
}

public class SignUpPresenterImpl: SignUpPresenter {
   
    private weak var view: SignUpViewController?
    private weak var coodinator: SignUpCoordinator?
    
    public init(view: SignUpViewController?, coodinator: SignUpCoordinator?) {
        self.view = view
        self.coodinator = coodinator
    }
}
