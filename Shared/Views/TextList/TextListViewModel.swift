//
//  TextListViewModel.swift
//  words
//
//  Created by Dmitriy Loktev on 16.01.2021.
//

import Foundation
import Combine
import CoreData
import SwiftUI

extension TextList {
    
    class ViewModel:  NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
        
        @Published var texts: [WText] = []
        @Published var selected: NSManagedObjectID? = nil
        @Published var refreshingID = UUID()
        
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
            
            guard let items = controller.fetchedObjects as? [WText]
            else { return }
            print("controller did change content", items)
            texts = items
            refreshingID = UUID()
        }
        
        func addItem() {
            withAnimation {
                let newItem = WText(context: viewContext)
                newItem.createdAt = Date()
                newItem.updatedAt = Date()
                newItem.content = ""
                
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
        
        func editItem(item: WText, title: String, text: String) {
            print("editItem", title, text)
            
            withAnimation {
                item.title = title
                item.content = text
                item.updatedAt = Date()
                
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
        
        func deleteItem(item: WText) {
            withAnimation {
                viewContext.delete(item)
                
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
