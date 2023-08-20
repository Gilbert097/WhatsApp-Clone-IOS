//
//  FirebaseStorageAdapter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 19/08/23.
//

import Foundation
import FirebaseStorage

public typealias StorageUploadResult = Swift.Result<Void, StorageClientError>
public enum StorageClientError: Error {
    case uploadError
}

public protocol StorageClient {
    func upload(query: StorageQuery, completion: @escaping (StorageUploadResult) -> Void)
}

class FirebaseStorageAdapter: StorageClient {
    
    private var TAG: String { String(describing: FirebaseStorageAdapter.self) }
    
    public func upload(query: StorageQuery, completion: @escaping (StorageUploadResult) -> Void) {
        
        let rooReference = Storage
            .storage()
            .reference()
        
        let (childReference, child) = findChild(query: query, root: rooReference)
        
        childReference
            .putData(child.value!, metadata: nil) { [weak self] metadata, error in
                guard let self = self else { return }
                if error == nil {
                    completion(.success(()))
                } else if let error = error {
                    LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
                    completion(.failure(.uploadError))
                }
            }
    }
    
    private func findChild(query: StorageQuery, root: StorageReference) -> (reference: StorageReference, child: StorageQuery) {
        guard let child = query.child else { return (root, query) }
        let childPath = root.child(child.path)
        
        if child.hasChild()  {
            return findChild(query: child, root: childPath)
        } else {
            return (childPath, child)
        }
    }
}

public class StorageQuery {
    
    public let path: String
    public let value: Data?
    public let child: StorageQuery?
    
    public init(path: String, value: Data? = nil, child: StorageQuery? = nil) {
        self.path = path
        self.value = value
        self.child = child
    }
    
    public func hasChild() -> Bool { self.child != nil }
}
