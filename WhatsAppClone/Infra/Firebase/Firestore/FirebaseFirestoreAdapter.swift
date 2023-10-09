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
public typealias DatabaseRetrieveValuesResult = Swift.Result<[Data], DatabaseClientError>

public protocol DatabaseClient {
    func create(query: DatabaseQuery, completion: @escaping (DatabaseCreateResult) -> Void)
    func update(query: DatabaseQuery, completion: @escaping (DatabaseUpdateResult) -> Void)
    func retrieve(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveResult) -> Void)
    func retrieveValues(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveValuesResult) -> Void)
    func addChangeListener(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveValuesResult) -> Void) -> DatabaseRegisterListener
}

class FirebaseFirestoreAdapter: DatabaseClient {
    
    private var TAG: String { String(describing: FirebaseFirestoreAdapter.self) }
    
    public func create(query: DatabaseQuery, completion: @escaping (DatabaseCreateResult) -> Void) {
        guard let (itemReference, item) = findItemReferenceWithDatabaseQuery(query: query) else { return }
        guard let data = item.data, let dataToJson = data.toJson() else { return }
        
        itemReference.setData(dataToJson) { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                completion(.success(()))
            } else if let error = error {
                LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
                completion(.failure(.createError))
            }
        }
    }
    
    public func addChangeListener(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveValuesResult) -> Void) -> DatabaseRegisterListener {
        let (rootReference, firebaseQuery) = findRootReferenceWithFirebaseQuery(query: query)
        
        let addSnapshotListener: (QuerySnapshot?, Error?) -> Void = { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                let datas = querySnapshot
                    .documents
                    .map({ $0.value })
                    .compactMap { $0 }
                
                // TODO[GIL] - Implementação da POC.
                let all = querySnapshot
                    .documents
                    .map({ $0.data() })
                print("All documents: \(all)")
                querySnapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        print("New document: \(diff.document.data())")
                    }
                    if (diff.type == .modified) {
                        print("Modified document: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed document: \(diff.document.data())")
                    }
                }
                
                completion(.success(datas))
            } else {
                completion(.failure(.valueNotFound))
            }
        }
        var registration: ListenerRegistration!
        if let firebaseQuery = firebaseQuery {
            registration = firebaseQuery.addSnapshotListener(addSnapshotListener)
        } else {
            registration = rootReference.addSnapshotListener(addSnapshotListener)
        }
        return FirestoreRegiterListener(registration: registration)
    }
    
    public func update(query: DatabaseQuery, completion: @escaping (DatabaseUpdateResult) -> Void) {
        guard let (itemReference, item) = findItemReferenceWithDatabaseQuery(query: query) else { return }
        guard let data = item.data, let dataToJson = data.toJson() else { return }
        itemReference.updateData(dataToJson) { [weak self] error in
                guard let self = self else { return }
                if error == nil {
                    completion(.success(()))
                } else if let error = error {
                    LogUtils.printMessage(tag: self.TAG, message: error.localizedDescription)
                    completion(.failure(.updateError))
                }
            }
    }
    
    private func findItemReferenceWithDatabaseQuery(query: DatabaseQuery, itemReference: DocumentReference? = nil) -> (reference: DocumentReference, item: DatabaseQueryItem)? {
        let rootReference = findRootReference(query: query, itemReference: itemReference)
        guard let item = query.item else { return nil }
        let itemReference = rootReference.document(item.path)
        
        if let itemQuery = item.query {
            return findItemReferenceWithDatabaseQuery(query: itemQuery, itemReference: itemReference)
        } else {
            return (itemReference, item)
        }
    }
    
    private func findRootReference(query: DatabaseQuery, itemReference: DocumentReference? = nil) -> CollectionReference {
        if let itemReference = itemReference {
            return itemReference
                .collection(query.path)
        } else {
            return Firestore
                .firestore()
                .collection(query.path)
        }
    }
    
    public func retrieve(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveResult) -> Void) {
        guard let (itemReference, _) = findItemReferenceWithDatabaseQuery(query: query) else { return }
        itemReference.getDocument { snapshot, error in
                guard
                    let snapshot = snapshot,
                    let value = snapshot.value
                else { return completion(.failure(DatabaseClientError.valueNotFound))}
                completion(.success(value))
            }
    }
    
    public func retrieveValues(query: DatabaseQuery, completion: @escaping (DatabaseRetrieveValuesResult) -> Void) {
        let (rootReference, firebaseQuery) = findRootReferenceWithFirebaseQuery(query: query)
        
        let getDocumentsCompletion: (QuerySnapshot?, Error?) -> Void = { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                let datas = querySnapshot
                    .documents
                    .map({ $0.value })
                    .compactMap { $0 }
                completion(.success(datas))
            } else {
                completion(.failure(.valueNotFound))
            }
        }
        
        if let firebaseQuery = firebaseQuery {
            firebaseQuery.getDocuments(completion: getDocumentsCompletion)
        } else {
            rootReference.getDocuments(completion: getDocumentsCompletion)
        }
    }
    
    private func findRootReferenceWithFirebaseQuery(query: DatabaseQuery, itemReference: DocumentReference? = nil) -> (reference: CollectionReference, firebaseQuery: Query?) {
        let rootReference = findRootReference(query: query, itemReference: itemReference)
        
        if let item = query.item {
            let itemReference = rootReference.document(item.path)
            guard let itemSubQuery = item.query else { return (rootReference, nil) }
            return findRootReferenceWithFirebaseQuery(query: itemSubQuery, itemReference: itemReference)
        } else {
            var firebaseQuery: Query? = nil
            if let condition = query.condition {
                firebaseQuery = rootReference.whereField(condition.field, isEqualTo: condition.value)
            }
            return (rootReference, firebaseQuery)
        }
    }
}

