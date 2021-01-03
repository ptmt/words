//
//  wordsApp.swift
//  Shared
//
//  Created by Dmitriy Loktev on 01.01.2021.
//

import SwiftUI

@main
struct WordsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
