//
//  AddContactPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 24/08/23.
//

import Foundation

public protocol AddContactPresenter {
    func addButtonAction(email: String)
}

class AddContactPresenterImpl: AddContactPresenter {
    
    private var TAG: String { String(describing: AddContactPresenterImpl.self) }
   
    private let coordinator: AddContactCoordinator
    private let userService: UserService
    
    public init(coordinator: AddContactCoordinator, userService: UserService) {
        self.coordinator = coordinator
        self.userService = userService
    }

    public func addButtonAction(email: String) {
        self.userService.retrieve(email: email) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                LogUtils.printMessage(tag: self.TAG, message: "Retrieve user success! name: \(user.name)")
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "Retrieve user failure!")
            }
        }
    }
}
