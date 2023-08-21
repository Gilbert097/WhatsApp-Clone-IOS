//
//  FirebaseFirestoreAdapter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation
import FirebaseFirestore

public typealias DatabaseCreateResult = Swift.Result<Void, DatabaseClientError>
public typealias DatabaseUpdateResult = Swift.Result<Void, DatabaseClientError>
public typealias DatabaseRetrieveResult = Swift.Result<Data, DatabaseClientError>

public protocol DatabaseClient {
    func create(query: DatabaseQuery, completion: @escaping (DatabaseCreateResult) -> Void)
    func update(query: DatabaseQuery, completion: @escaping (DatabaseUpdateResult) -> Void)
    func retrieve(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveResult) -> Void)
}

class FirebaseFirestoreAdapter: DatabaseClient {
    
    private var TAG: String { String(describing: FirebaseFirestoreAdapter.self) }
    
    public func create(query: DatabaseQuery, completion: @escaping (DatabaseCreateResult) -> Void) {
        guard let data = query.data, let dataToJson = data.toJson() else { return }
        buildDocumentReference(query: query)
            .setData(dataToJson) { [weak self] error in
                guard let self = self else { return }
                if error == nil {
                    completion(.success(()))
                } else if let error = error {
                    LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
                    completion(.failure(.createError))
                }
            }
    }
    
    public func update(query: DatabaseQuery, completion: @escaping (DatabaseUpdateResult) -> Void) {
        guard let data = query.data, let dataToJson = data.toJson() else { return }
        buildDocumentReference(query: query)
            .updateData(dataToJson) { [weak self] error in
                guard let self = self else { return }
                if error == nil {
                    completion(.success(()))
                } else if let error = error {
                    LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
                    completion(.failure(.updateError))
                }
            }
    }
    
    private func buildDocumentReference(query: DatabaseQuery) -> DocumentReference {
        Firestore
            .firestore()
            .collection(query.path)
            .document(query.item)
    }
    
    public func retrieve(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveResult) -> Void) {
        Firestore
            .firestore()
            .collection(query.path)
            .document(query.item)
            .getDocument { snapshot, error in
                guard
                    let snapshot = snapshot,
                    let value = snapshot.value
                else { return completion(.failure(DatabaseClientError.valueNotFound))}
                completion(.success(value))
            }
    }
}

