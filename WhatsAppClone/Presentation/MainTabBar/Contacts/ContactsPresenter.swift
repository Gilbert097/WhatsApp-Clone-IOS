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
    func searchTheList(text: String)
    func clearSearch()
}

class ContactsPresenterImpl: ContactsPresenter {
   
    private let view: ContactsView
    private let coordinator: ContactsCoordinator
    private let contactService: ContactService
    public var contactList: [UserModel] = []
    private var originalList: [UserModel] = []
    
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
        self.view.display(viewModel: .init(isLoading: true))
        self.contactService.getAllUserContacts(user: .init(userApp: currentUser)) { [weak self] result in
            guard let self = self else { return }
            self.view.display(viewModel: .init(isLoading: false))
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
    
    public func searchTheList(text: String) {
        if self.originalList.isEmpty {
            self.originalList = self.contactList
        } else {
            self.contactList = self.originalList
        }
        
        self.contactList = self.contactList.filter({ $0.name.lowercased().contains(text)})
        self.view.loadList()
    }
    
    public func clearSearch() {
        self.contactList = self.originalList
        self.originalList = []
        self.view.loadList()
    }
}
