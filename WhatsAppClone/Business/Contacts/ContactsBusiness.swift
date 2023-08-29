//
//  ContactsBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 29/08/23.
//

import Foundation

public typealias AddNewContactResult = Swift.Result<Void, AddNewContactError>

public protocol ContactsBusiness {
    func addNewContact(email: String, completion: @escaping (AddNewContactResult) -> Void)
}

class ContactsBusinessImpl: ContactsBusiness {
    
    private var TAG: String { String(describing: ContactsBusinessImpl.self) }
    
    private let userService: UserService
    private let contactService: ContactService
    
    public init(userService: UserService, contactService: ContactService) {
        self.userService = userService
        self.contactService = contactService
    }
    
    public func addNewContact(email: String, completion: @escaping (AddNewContactResult) -> Void) {
        
        self.userService.retrieve(email: email) { [weak self] retrieveResult in
            guard let self = self else { return }
            switch retrieveResult {
            case .success(let user):
                guard let currentUser = UserSession.shared.read() else { return }
                let request = ContactRequest(currentUserId: currentUser.id, userToAdd: user)
                self.contactService.add(request: request) { addResult in
                    switch addResult {
                    case .success:
                        completion(.success(()))
                    case .failure:
                        completion(.failure(.add))
                    }
                }
            case .failure:
                completion(.failure(.getUser))
            }
        }
    }
}
