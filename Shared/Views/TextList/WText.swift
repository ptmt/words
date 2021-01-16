//
//  WText.swift
//  words
//
//  Created by Dmitriy Loktev on 16.01.2021.
//

import Foundation
import CoreData

extension WText {
    static var latestTextsFetchRequest: NSFetchRequest<WText> {
        let request: NSFetchRequest<WText> = WText.fetchRequest()
        // request.predicate = NSPredicate(format: "dueDate < %@", Date.nextWeek() as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        
        return request
    }
}
