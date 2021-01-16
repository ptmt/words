//
//  Sidebar.swift
//  words
//
//  Created by Dmitriy Loktev on 06.01.2021.
//

import Foundation
import SwiftUI

struct Sidebar: View {
    @State var state: NavigationItem? = .texts
    var body: some View {
        VStack {
            List {
                Section(header: Text("English")) {
                    NavigationLink(
                        destination: NavigationDispatcher(item: .texts),
                        tag: NavigationItem.texts,
                        selection: $state,
                        label: {
                            Label("Texts", systemImage: "house" )
                        })
                    NavigationLink(
                        destination:NavigationDispatcher(item: .words),
                        tag: NavigationItem.words,
                        selection: $state,
                        label: {
                            Label("Words", systemImage: "textformat.abc")
                        })
                  
                }
//                Section(header: Text("German")) {
//                    NavigationLink(
//                        destination: firstTab,
//                        tag: Tab.texts,
//                        selection: $state,
//                        label: {
//                            Label("Texts", systemImage: "house" )
//                        })
//                    NavigationLink(
//                        destination: Text("test"),
//                        tag: Tab.words,
//                        selection: $state,
//                        label: {
//                            Label("Words", systemImage: "textformat.abc")
//                        })
//                    NavigationLink(
//                        destination: Text("test"),
//                        tag: Tab.settings,
//                        selection: $state,
//                        label: {
//                            Label("Settings", systemImage: "gearshape")
//                        })
//                }
                Section(header: Text("Favorites")) {
                    
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Sidebar")
            HStack {
                Button("Add language") {
                    
                }
                .buttonStyle(BorderlessButtonStyle())
                .fixedSize()
                .padding()
                Spacer()
            }
        }
    }
}

struct SidebarLayout_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
