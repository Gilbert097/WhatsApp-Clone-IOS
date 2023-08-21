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

class ProfilePictureServiceImpl: ProfilePictureService {
    
    private var TAG: String { String(describing: ProfilePictureServiceImpl.self) }
    
    private let storageClient: StorageClient
    
    public init(storageClient: StorageClient) {
        self.storageClient = storageClient
    }
    
    public func updload(imageData: Data, completion: @escaping (ProfilePictureServiceUploadResult) -> Void) {
        guard let userApp = UserSession.shared.read() else { return }
        let userQuery = StorageQuery(path: userApp.id, value: imageData)
        let profileQuery = StorageQuery(path: "perfil", child: userQuery)
        let rootQuery = StorageQuery(path: "imagens", child: profileQuery)
        
        self.storageClient.upload(query: rootQuery) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let url):
                LogUtils.printMessage(tag: self.TAG, message: url.absoluteString)
                completion(.success(()))
            case .failure:
                completion(.failure(.uploadError))
            }
        }
    }
}
