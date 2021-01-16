//
//  TextList.swift
//  words
//
//  Created by Dmitriy Loktev on 06.01.2021.
//

import Foundation
import SwiftUI

struct TextList: View {
    
    @ObservedObject var vm: ViewModel
    var emptyListView: some View {
          Text("No text, start by adding one")
      }
    
    var objectsListView: some View {
        List {
            ForEach(vm.texts) { text in
                NavigationLink(
                    destination: HintedText(
                        title: text.title ?? "",
                        updatedAt: "just now",
                        text: text.content ?? ""),
                    tag: text.objectID,
                    selection: $vm.selected,
                    label: {
                        TextRowView(text: text)
                    })
            }
            .onDelete(perform: vm.deleteItems)
        }
        .listStyle(InsetListStyle())
        }
    
    @ViewBuilder
    var listView: some View {
        if vm.texts.isEmpty {
            emptyListView
        } else {
            objectsListView
        }
    }
    
    var addButton: some View {
        Button(action: {
            vm.addItem()
        }) {
            Image(systemName: "plus")
        }
    }
  
    
    var body: some View {
        #if os(macOS)
        listView
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                addButton
                Spacer()
            }
        }
        .navigationTitle(Text("Words"))
        #else
        listView.navigationBarItems(
            leading:  EditButton(),
            trailing: addButton)
            #endif
    }
    
    
}

struct TextList_Previews: PreviewProvider {
    static var previews: some View {
        TextList(vm: TextList.ViewModel(PersistenceController.preview.container.viewContext))
    }
}
