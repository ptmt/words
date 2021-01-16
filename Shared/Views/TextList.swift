//
//  TextList.swift
//  words
//
//  Created by Dmitriy Loktev on 06.01.2021.
//

import Foundation
import SwiftUI


extension WText {
    static var latestTextsFetchRequest: NSFetchRequest<WText> {
        let request: NSFetchRequest<WText> = WText.fetchRequest()
        // request.predicate = NSPredicate(format: "dueDate < %@", Date.nextWeek() as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        
        return request
    }
}


extension TextList {
    
    class ViewModel:  NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
        
        @Published var texts: [WText] = []
        @Published var selected: NSManagedObjectID? = nil
        
        private let fetchController: NSFetchedResultsController<WText>
        
        let viewContext: NSManagedObjectContext
        
        init(_ managedObjectContext: NSManagedObjectContext) {
            self.viewContext = managedObjectContext
            fetchController = NSFetchedResultsController(fetchRequest: WText.latestTextsFetchRequest,
                                                         managedObjectContext: managedObjectContext,
                                                         sectionNameKeyPath: nil, cacheName: nil)
            
            super.init()
            fetchController.delegate = self
            
            do {
                try fetchController.performFetch()
                texts = fetchController.fetchedObjects ?? []
                selected = texts.first?.objectID
            } catch {
                print("failed to fetch items!")
            }
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            guard let todoItems = controller.fetchedObjects as? [WText]
            else { return }
            
            texts = todoItems
        }
        
        func addItem() {
            print("addItem")
            withAnimation {
                let newItem = WText(context: viewContext)
                newItem.createdAt = Date()
                newItem.updatedAt = Date()
                newItem.title = "No title"
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { texts[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}

struct TextRowView: View {
    var text: WText
    var body: some View {
        VStack(alignment: .leading) {
            Text(text.title ?? "No title").font(.headline)
            HStack {
               Text("\(text.updatedAt!, formatter: itemFormatter)")
                if let link = text.link {
                    Text(link.absoluteString).foregroundColor(.secondary)
                }
            }
            Text("Content excerpt...")
        }
    }
}
struct TextList: View {
    
    @ObservedObject var vm: ViewModel
    var body: some View {
        List {
            ForEach(vm.texts) { text in
                NavigationLink(
                    destination: HintedText(
                        title: text.title!,
                        updatedAt: "just now",
                        text: text.content ?? "No content"),
                    tag: text.objectID,
                    selection: $vm.selected,
                    label: {
                        TextRowView(text: text)
                    })
            }
            .onDelete(perform: vm.deleteItems)
        }
        .listStyle(InsetListStyle())
        .toolbar {
            
            #if os(iOS)
            EditButton()
            #endif
            
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: {
                    vm.addItem()
                }) {
                    Label("Add Item", systemImage: "plus")
                }
                Spacer()
            }
        }
        .navigationTitle("Texts")
        // .navigationSubtitle("\(vm.texts.count) records")
    }
    
    
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()


struct TextList_Previews: PreviewProvider {
    static var previews: some View {
        TextList(vm: TextList.ViewModel(PersistenceController.preview.container.viewContext))
    }
}
