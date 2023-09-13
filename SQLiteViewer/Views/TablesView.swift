//
//  TablesView.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 29.08.23.
//

import SwiftUI

struct TablesView: View {
    @EnvironmentObject var db: Database
    @State var selection: Table?
    var body: some View {
        VStack{
            
            HStack{
                Text(db.name)
                    .font(.largeTitle)
            }
            HStack{
                VStack{
                    List(db.tables , id: \.id) { table in
                        Text(table.name)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                selection = table
                                guard let tableName = selection?.name else {
                                    print("Table name is nil")
                                    return
                                }
                                let tablename = db.getTableAttributes(tableName)
                                let attributes = db.getTableAttributes(tableName)
//                                print(tablename)
                                for name in attributes{
                                    db.addOutput(text: name, color: .yellow)
                                }
                            }
                    }.onAppear(perform: db.loadTables)
                    
                    
                    Text(selection?.name ?? "select a table")
                        .font(.title3)
                    Terminal()
                }
            }
        }
    }
}



#Preview {
    TablesView()
}





