//
//  ContactsPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import Foundation

public protocol ContactsPresenter {
    func addButtonAction()
}

class ContactsPresenterImpl: ContactsPresenter {
   
    private let coordinator: ContactsCoordinator
    
    public init(coordinator: ContactsCoordinator) {
        self.coordinator = coordinator
    }
    
    public func addButtonAction() {
        self.coordinator.showAddContact()
    }
}
