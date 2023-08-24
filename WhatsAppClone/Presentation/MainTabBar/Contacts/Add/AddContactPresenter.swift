//
//  AddContactPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 24/08/23.
//

import Foundation

public protocol AddContactPresenter {
}

class AddContactPresenterImpl: AddContactPresenter {
   
    private let coordinator: AddContactCoordinator
    
    public init(coordinator: AddContactCoordinator) {
        self.coordinator = coordinator
    }

}
