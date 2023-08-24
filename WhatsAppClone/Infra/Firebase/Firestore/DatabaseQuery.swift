//
//  DatabaseQuery.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 17/08/23.
//

import Foundation

public class DatabaseQuery {
    
    public let path: String
    public let item: DatabaseQueryItem?
    public let condition: DatabaseQueryCondition?
    
    public init(path: String, item: DatabaseQueryItem? = nil, condition: DatabaseQueryCondition? = nil) {
        self.path = path
        self.item = item
        self.condition = condition
    }
}

public class DatabaseQueryItem {
    
    public let query: DatabaseQuery?
    public let path: String
    public let data: Data?
    
    public init(query: DatabaseQuery? = nil, path: String, data: Data? = nil) {
        self.query = query
        self.path = path
        self.data = data
    }
}

public struct DatabaseQueryCondition {
    public let field: String
    public let value: Any
}
