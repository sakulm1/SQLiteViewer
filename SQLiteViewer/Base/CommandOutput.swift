//
//  CommandOutput.swift
//  SQLiteViewer
//
//  Created by Lukas Maile on 14.09.23.
//

import Foundation
import SwiftUI


struct CommandOutput{
    var text: String
    var color: Color?
    var id: UUID
    
    /// Erstellt eine neue CommandOutput-Instanz.
    /// - Parameters:
    ///   - text: Der Text der Ausgabe.
    ///   - color: Eine optionale Farbe für den Textausgabe.
    init(text: String,  color: Color? = nil) {
        self.text = text
        self.color = color
        self.id = UUID()
    }
}

