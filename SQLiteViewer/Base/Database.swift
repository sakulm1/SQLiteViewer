//
//  Database.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 29.08.23.
//

import Foundation
import SQLite3
import SwiftUI

#warning("In der Table class den Parameter 'db' fixen. Denk nicht das dass ist best practice 😔")

class Database: ObservableObject{
    @Published var path: String
    @Published var name: String
    @Published var tables: [Table]
    @Published var co: [CommandOutput]
    var connection: OpaquePointer?
    
    init(path: String, name: String, tables: [Table], co: [CommandOutput]) {
        self.path = path
        self.name = name
        self.tables = tables
        self.co = co
        self.connection = openDatabase()
    }
    
    func clear(){
        path = ""
        name = ""
        tables.removeAll()
        co.removeAll()
    }
    
    func openDatabase() -> OpaquePointer? {
      var database: OpaquePointer?
        
        if sqlite3_open(self.path, &database) == SQLITE_OK {
            
            print("Successfully opened connection to database at \(self.path)")
            return database
            
      } else {
          
          print("Unable to open database on " + self.path)
          return nil
          
      }
    }
    
    func loadTables() {
        
        self.tables.removeAll()
        
        let getTablesString = "SELECT Name FROM sqlite_master WHERE type='table';"
        
        let querry = self.querry(queryStatementString: getTablesString)
        
        let tables = querry?.compactMap{ $0["name"] as? String} ?? ["No tables found :("]
        
        self.addOutput(text: "Load Table Names from Database", color: .red)
        
        for table in tables {
            let newTable = Table(name: String(table), db: self)
            self.tables.append(newTable)
            self.addOutput(text: newTable.name, color: .pink)
        }
    }
    
    func getTables() -> [Table]{
        return self.tables
    }
    
    func querry(queryStatementString: String) -> [[String: Any]]? {
        var queryStatement: OpaquePointer?
        let db = self.connection
        var resultData = [[String: Any]]()
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            let columnCount = sqlite3_column_count(queryStatement)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var rowData = [String: Any]()
                
                for i in 0..<columnCount {
                    let columnName = String(cString: sqlite3_column_name(queryStatement, i))
                    
                    switch sqlite3_column_type(queryStatement, i) {
                    case SQLITE_INTEGER:
                        let intValue = sqlite3_column_int(queryStatement, i)
                        rowData[columnName] = intValue
                    case SQLITE_TEXT:
                        guard let textValue = sqlite3_column_text(queryStatement, i) else {
                            print("Query result is nil for column: \(columnName)")
                            return nil
                        }
                        rowData[columnName] = String(cString: textValue)
                    default:
                        print("Unhandled data type for column: \(columnName) -> \(sqlite3_column_type(queryStatement, i))")
                    }
                }
                
                resultData.append(rowData)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
            return nil
        }
        
        sqlite3_finalize(queryStatement)
        return resultData
    }
    
    func getTableAttributes(_ tableName: String) -> [String]{
        let statement = "Select * from \(tableName)"
        let values = self.querry(queryStatementString: statement)
        #warning("Add guard")
        let columnNames = values?.compactMap{ $0["name"] as? String }
        
        return columnNames ?? ["FATAL ERROR: No attributes found"]
    }
    
    func addOutput(text: String, color: Color?){
        let newOutput = CommandOutput(text: text, color: color)
        self.co.append(newOutput)
    }
}
