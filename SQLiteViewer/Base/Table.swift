//
//  Table.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 09.09.23.
//

import Foundation


class Table{
    
    var name: String
    var attributes: [String]?
    var primaryKey: String?
    var foreignKey: String?
    var rows: [[String]]?
    var id: UUID
    var db: Database?
    
    init(name: String, attributes: [String]? = nil, primaryKey: String? = nil, foreignKey: String? = nil, rows: [[String]]? = nil, db: Database? = nil) {
        self.name = name
        self.attributes = attributes
        self.primaryKey = primaryKey
        self.foreignKey = foreignKey
        self.rows = rows
        self.db = db
        self.id = UUID()
    }
    
    func fill(tableName: String){
        self.attributes = db?.getTableAttributes(tableName)
    }
}
