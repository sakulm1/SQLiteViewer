//
//  Terminal.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 14.09.23.
//

import SwiftUI

struct Terminal: View {
    
    @EnvironmentObject var db: Database
    
    var body: some View {
        ScrollView{
            ForEach(db.co, id: \.id) { line in
                Text(line.text)
                    .foregroundColor(line.color)
                    
            }  
        }
        .background(Color.black)
    }
    
}





struct Terminal_Previews: PreviewProvider {
    static var previews: some View {
        Terminal()
    }
}
