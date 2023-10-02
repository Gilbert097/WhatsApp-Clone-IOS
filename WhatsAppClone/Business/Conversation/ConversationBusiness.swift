//
//  ConversationBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

public typealias SaveConversationBusinessResult = Swift.Result<Void, ConverstaionBusinessError>

public protocol ConversationBusiness {
    func saveLastConversation(detailRequest: ConversationDetailRequest,
                              completion: @escaping (SaveConversationBusinessResult) -> Void)
}

class ConversationBusinessImpl: ConversationBusiness {
    private var TAG: String { String(describing: ConversationBusinessImpl.self) }
    
    private let conversationService: ConversationService
    
    public init(conversationService: ConversationService) {
        self.conversationService = conversationService
    }
    
    public func saveLastConversation(detailRequest: ConversationDetailRequest,
                              completion: @escaping (SaveConversationBusinessResult) -> Void) {
        saveConversationToSenderAndRecipientUser(detailRequest: detailRequest, completion: completion)
    }
    
    private func saveConversationToSenderAndRecipientUser(detailRequest: ConversationDetailRequest,
                                                          completion: @escaping (SaveConversationBusinessResult) -> Void) {
        let group = DispatchGroup()
        var senderUserResult: SaveConversationBusinessResult!
        let senderUserRequest = detailRequest.toConversationRequest(target: .sender)
        group.enter()
        saveConversation(request: senderUserRequest, completion: { result in
            senderUserResult = result
            group.leave()
        })
        
        var recipientUserResult: SaveConversationBusinessResult!
        let recipientUserRequest = detailRequest.toConversationRequest(target: .recipient)
        group.enter()
        saveConversation(request: recipientUserRequest,  completion: { result in
            recipientUserResult = result
            group.leave()
        })
        
        group.notify(queue: .main) {
            if case let .failure(error) = senderUserResult {
                completion(.failure(error))
            } else if case let .failure(error) = recipientUserResult {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    private func saveConversation(request: ConversationRequest,
                                  completion: @escaping (SaveConversationBusinessResult) -> Void) {
        self.conversationService.saveLastConversation(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                LogUtils.printMessage(tag: self.TAG, message: "saveConversation success!")
                completion(.success(()))
            case .failure:
                LogUtils.printMessage(tag: self.TAG, message: "saveConversation error!")
                completion(.failure(.senderUser))
            }
        }
    }
}
