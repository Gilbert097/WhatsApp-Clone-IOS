//
//  ImagePickerManager.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 18/08/23.
//

import Foundation
import UIKit

public protocol ImagePickerDelegate: NSObject {
    func didSelect(data: Data)
}

class ImagePickerManager: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    public weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController? = nil) {
        self.presentationController = presentationController
        self.pickerController = UIImagePickerController()
        self.pickerController.sourceType = .savedPhotosAlbum
    }
    
    public func present() {
        self.presentationController?.present(self.pickerController, animated: true)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let data = imageSelected.jpegData(compressionQuality: 3.0) {
            self.delegate?.didSelect(data: data)
        }
    }
}

extension ImagePickerManager: UINavigationControllerDelegate { }
