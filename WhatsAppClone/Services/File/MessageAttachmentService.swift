//
//  MessageAttachmentService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 21/09/23.
//

import Foundation

public typealias MessageAttachmentServiceUploadResult = Swift.Result<URL, MessageAttachmentServiceError>
public enum MessageAttachmentServiceError: Error {
    case uploadError
}

public protocol MessageAttachmentService {
    func updload(name: String, imageData: Data, completion: @escaping (MessageAttachmentServiceUploadResult) -> Void)
}

class MessageAttachmentServiceImpl: MessageAttachmentService {
    
    private var TAG: String { String(describing: ProfilePictureServiceImpl.self) }
    
    private let storageClient: StorageClient
    
    public init(storageClient: StorageClient) {
        self.storageClient = storageClient
    }
    
    public func updload(name: String, imageData: Data, completion: @escaping (MessageAttachmentServiceUploadResult) -> Void) {
        let imageQuery = StorageQuery(path: name, value: imageData)
        let mensageQuery = StorageQuery(path: "mensages", child: imageQuery)
        let rootQuery = StorageQuery(path: "imagens", child: mensageQuery)
        
        self.storageClient.upload(query: rootQuery) { result in
            switch result {
            case .success(let url):
                completion(.success(url))
            case .failure:
                completion(.failure(.uploadError))
            }
        }
    }
}
