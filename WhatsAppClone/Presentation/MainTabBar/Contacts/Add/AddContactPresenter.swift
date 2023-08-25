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
    private let contactService: ContactService
    
    public init(coordinator: AddContactCoordinator, userService: UserService, contactService: ContactService) {
        self.coordinator = coordinator
        self.userService = userService
        self.contactService = contactService
    }

    public func addButtonAction(email: String) {
        // Criar ContactBusiness
        self.userService.retrieve(email: email) { [weak self] retrieveResult in
            guard let self = self else { return }
            switch retrieveResult {
            case .success(let user):
                guard let currentUser = UserSession.shared.read() else { return }
                let request = ContactRequest(currentUserId: currentUser.id, userToAdd: user)
                self.contactService.add(request: request) { addResult in
                    switch addResult {
                    case .success:
                        LogUtils.printMessage(tag: self.TAG, message: "Add contact success!")
                    case .failure:
                        LogUtils.printMessage(tag: self.TAG, message: "Retrieve user failure!")
                    }
                }
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "Retrieve user failure!")
            }
        }
    }
}
