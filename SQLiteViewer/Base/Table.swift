//
//  Table.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 09.09.23.
//

import Foundation


class Table{
    
    
    var name: String
    var attributes: [[String : String]]?
    var primaryKey: String?
    var foreignKey: String?
    var id: UUID
    
    init(name: String, attributes: [[String : String]]? = nil, primaryKey: String? = nil, foreignKey: String? = nil) {
        self.name = name
        self.attributes = attributes
        self.primaryKey = primaryKey
        self.foreignKey = foreignKey
        self.id = UUID()
    }
}
