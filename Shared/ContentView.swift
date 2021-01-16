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
    
    var iosBody: some View {
        TabView {
            NavigationView {
                NavigationDispatcher(item: .texts)
                    .navigationTitle(Text("Texts"))
                    
            }.tabItem {
                Image(systemName: "house")
                Text("Texts")
            }
            NavigationView {
                NavigationDispatcher(item: .words)
                    .navigationTitle(Text("Texts"))
            }.tabItem {
                Image(systemName: "textformat.abc")
                Text("Words")
            }
        }
    }
    
    var macOsBody: some View {
        NavigationView {
            Sidebar()
            empty
            empty2
        }
    }
    
    var body: some View {
        #if os(macOS)
        macOsBody
        #endif
        #if os(iOS)
        iosBody
        #endif
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
