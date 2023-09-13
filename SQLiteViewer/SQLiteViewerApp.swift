//
//  SQLiteViewerApp.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 03.08.23.
//

import SwiftUI

@main
struct SQLiteViewerApp: App {
    @StateObject var db = Database(path: "file:///Users/lukasmaile/Desktop/Car_Database.db", name: "Car_Database.db", tables: [Table(name: "No Tables found", db: nil)], co: [CommandOutput(text: "initialized Terminal ")])
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(db)
        }
    }
}
