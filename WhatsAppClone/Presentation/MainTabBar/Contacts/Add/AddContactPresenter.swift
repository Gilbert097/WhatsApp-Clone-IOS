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
   
    private let view: AddContactView
    private let coordinator: AddContactCoordinator
    private let business: ContactsBusiness
    
    public init(view: AddContactView, coordinator: AddContactCoordinator, business: ContactsBusiness) {
        self.view = view
        self.coordinator = coordinator
        self.business = business
    }

    public func addButtonAction(email: String) {
        self.view.display(viewModel: .init(isLoading: true))
        self.business.addNewContact(email: email) { [weak self] result in
            guard let self = self else { return }
            self.view.display(viewModel: .init(isLoading: false))
            switch result {
            case .success:
                let okButton = AlertButtonModel(title: "Ok", action: { [weak self] in self?.coordinator.close() })
                self.view.showMessage(viewModel: .init(title: "Sucesso", message: "Contato adicionado sucesso!", buttons: [okButton]))
            case .failure:
                self.view.showMessage(viewModel: .init(title: "Error", message: "Error ao tentar adiocinar usuário!", buttons: [.init(title: "Ok")]))
            }
        }
    }
}
