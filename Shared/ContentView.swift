//
//  ContentView.swift
//  Shared
//
//  Created by Dmitriy Loktev on 01.01.2021.
//

import SwiftUI
import CoreData



enum Tab: String, Hashable {
    case texts, words, settings
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedTab = Tab.texts
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            Sidebar()
            #endif
            #if os(iOS)
            TabView {
                list
                    .navigationTitle(Text("List"))
                    .tabItem {
                        Image(systemName: "phone.fill")
                        Text("First Tab")
                    }
            }
            #endif
            #if os(macOS)
            empty
            #endif
            empty2
        }
    }
    
    var words: some View {
        VStack {
            Text("word 1")
            Text("word 2")
        }
    }
    
    var empty: some View {
        Text("Select a screen from the left")
    }
    
    var empty2: some View {
        Group { }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
