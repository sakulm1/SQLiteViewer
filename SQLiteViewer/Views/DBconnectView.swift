//
//  DBconnectView.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 29.08.23.
//

import SwiftUI

struct DBconnectView: View {
//    @ObservedObject var db: Database
//    var db: Database
    @EnvironmentObject var db: Database
    @State private var showFileImporter = false
    @State var btnDelete = true
    @State var btnEdit = false
    @State var btnEditText = "Edit"
    @State var dbPath: String = ""
    @State var dbName: String = ""
    var body: some View {
        VStack{
            HStack{
                VStack{
                    TextField("Database path", text: $dbPath)
                        .disabled(btnEdit == true ? false : true)
                    TextField("Name", text: $dbName)
                        .disabled(true)
                }
                VStack{
                    Button{
                        showFileImporter.toggle()
                    } label: {
                        Label("Choose DB", systemImage: "tablecells.badge.ellipsis")
                    }.disabled(btnEdit == false ? true : false)
                    
                    Button{
                        db.clear()
                    } label: {
                        Label("Delete", systemImage: "delete.left.fill")
                            .foregroundColor(.red)
                    }
                    .disabled(btnDelete || btnEdit == false ? true : false )
                }
                .fileImporter(
                    isPresented: $showFileImporter,
                    allowedContentTypes: [.data],
                    allowsMultipleSelection: false
                ){ result in
                    switch result {
                    case .success(let files):
                        files.forEach { file in
                            let gotAccess = file.startAccessingSecurityScopedResource()
                            if !gotAccess { return }
                            dbPath = file.absoluteString
                            dbName = String(file.pathComponents.last?.dropLast(3) ?? "")
                            btnDelete = false
                            file.stopAccessingSecurityScopedResource()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            HStack{
                Button{
                    btnEdit.toggle()
                    btnEditText = btnEdit == false ? "Edit" : "Save"
                    if btnEdit == false {
                        db.path = dbPath
                        db.name = dbName
                        
                        _ = db.openDatabase() //Test Connection to db
                    }
                    
                } label: {
                    Label(btnEditText, systemImage: "pencil")
                }
            }
        }
    }
}


struct DBconnectView_Previews: PreviewProvider {
    static var previews: some View {
        DBconnectView()
    }
}
