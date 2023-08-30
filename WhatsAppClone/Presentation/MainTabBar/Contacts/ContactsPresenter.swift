//
//  ContactsPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public protocol ContactsPresenter {
    var contactList: [UserModel] { get }
    func start()
    func stop()
    func addButtonAction()
}

class ContactsPresenterImpl: ContactsPresenter {
   
    private let view: ContactsView
    private let coordinator: ContactsCoordinator
    private let contactService: ContactService
    public var contactList: [UserModel] = []
    
    public init(view: ContactsView, coordinator: ContactsCoordinator, contactService: ContactService) {
        self.view = view
        self.coordinator = coordinator
        self.contactService = contactService
    }
    
    public func start() {
        loadContacts()
    }
    
    public func stop() {
        clearList()
    }
    
    private func loadContacts() {
        guard let currentUser = UserSession.shared.read() else { return }
        self.contactService.getAllUserContacts(user: .init(userApp: currentUser)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.contactList.append(contentsOf: users)
                self.view.loadList()
            case .failure:
                self.view.showMessage(viewModel: .init(title: "Error", message: "Error ao tentar recuperar lista de contatos!", buttons: [.init(title: "Ok")]))
            }
        }
    }
    
    private func clearList() {
        self.contactList = []
    }
    
    public func addButtonAction() {
        self.coordinator.showAddContact()
    }
}
