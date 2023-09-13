//
//  ContentView.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 03.08.23.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var db: Database
    //var db: Database
    @EnvironmentObject var db: Database
    var body: some View {
        TabView {
            DBconnectView()
                .tabItem {
                    Label("Database", systemImage: "externaldrive")
                }
            TablesView()
                .tabItem {
                    Label("Tables", systemImage: "tablecells")
                }
            TablesView()
                .tabItem {
                    Label("Settings", systemImage: "wrench.and.screwdriver.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
