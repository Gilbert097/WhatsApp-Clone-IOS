//
//  FirebaseFirestoreAdapter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation
import FirebaseFirestore

public typealias DatabaseCreateResult = Swift.Result<Void, DatabaseClientError>

public protocol DatabaseClient {
    func create(query: DatabaseQuery, completion: @escaping (DatabaseCreateResult) -> Void)
}

class FirebaseFirestoreAdapter: DatabaseClient {
    
    private var TAG: String { String(describing: FirebaseFirestoreAdapter.self) }
    
    public func create(query: DatabaseQuery, completion: @escaping (DatabaseCreateResult) -> Void) {
        guard let data = query.data.toJson() else { return }
        Firestore
            .firestore()
            .collection(query.path)
            .document(query.item)
            .setData(data) { [weak self] error in
                guard let self = self else { return }
                if error == nil {
                    completion(.success(()))
                } else if let error = error {
                    LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
                    completion(.failure(.createError))
                }
            }
    }
    
}

