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
                    List(db.tables ?? [Table(name: "Error")], id: \.id, selection: $selection) { table in
                        Text(table.name)
                    }.onAppear(
                        perform: db.loadTables
                    )
                    
                    Text(selection ?? "select a table")
                        .font(.title3)
                }
                
                VStack{
                    //table content :)
                }
                
            }
        }
    }
}

struct TablesView_Previews: PreviewProvider {
    static var previews: some View {
        TablesView()
    }
}
