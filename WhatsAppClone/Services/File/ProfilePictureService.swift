//
//  ProfilePictureService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 19/08/23.
//

import Foundation

public typealias ProfilePictureServiceUploadResult = Swift.Result<Void, ProfilePictureServiceError>
public enum ProfilePictureServiceError: Error {
    case uploadError
}

public protocol ProfilePictureService {
    func updload(imageData: Data, completion: @escaping (ProfilePictureServiceUploadResult) -> Void)
}

class ProfilePictureServiceImpl {
    
    private let storageClient: StorageClient
    
    public init(storageClient: StorageClient) {
        self.storageClient = storageClient
    }
    
    public func updload(imageData: Data, completion: @escaping (ProfilePictureServiceUploadResult) -> Void) {
        guard let userApp = UserSession.shared.read() else { return }
        let userQuery = StorageQuery(path: userApp.id, value: imageData)
        let profileQuery = StorageQuery(path: "perfil", child: userQuery)
        let rootQuery = StorageQuery(path: "imagens", child: profileQuery)
        
        self.storageClient.upload(query: rootQuery) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.uploadError))
            }
        }
    }
}
