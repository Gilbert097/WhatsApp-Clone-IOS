//
//  SettingsBusiness.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 21/08/23.
//

import Foundation

public typealias UploadPictureResult = Swift.Result<Void, UploadPictureError>

public protocol SettingsBusiness {
    func uploadProfilePicture(data: Data, completion: @escaping (UploadPictureResult) -> Void)
}

class SettingsBusinessImpl: SettingsBusiness {
    
    private let profilePictureService: ProfilePictureService
    private let userService: UserService
    
    public init(profilePictureService: ProfilePictureService, userService: UserService) {
        self.profilePictureService = profilePictureService
        self.userService = userService
    }
    
    public func uploadProfilePicture(data: Data, completion: @escaping (UploadPictureResult) -> Void) {
        self.profilePictureService.updload(imageData: data) { [weak self] uploadResult in
            guard let self = self else { return }
            switch uploadResult {
            case .success(let url):
                guard var currentUser = UserSession.shared.read() else { return completion(.failure(.updateUser))}
                currentUser.urlImage = url.absoluteString
                saveUserInSession(user: currentUser)
                self.updateUserInformation(userModel: .init(userApp: currentUser), completion: completion)
            case .failure:
                completion(.failure(.updload))
            }
        }
    }
    
    private func updateUserInformation(userModel: UserModel, completion: @escaping (UploadPictureResult) -> Void) {
        self.userService.update(model: userModel) { updateResult in
            switch updateResult {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.updateUser))
            }
        }
    }
}
