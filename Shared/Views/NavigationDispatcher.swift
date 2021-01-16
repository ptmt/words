//
//  NavigationDispatcher.swift
//  words
//
//  Created by Dmitriy Loktev on 09.01.2021.
//

import Foundation
import SwiftUI

enum NavigationItem {
    case words
    case texts
    
    var title: String {
        switch(self) {
        case .texts: return "Texts"
        case .words: return "Words"
        }
    }
}


struct NavigationDispatcher: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var item: NavigationItem
    
    var body: some View {
        switch(item) {
        case .texts: TextList(vm: TextList.ViewModel(viewContext))
        case .words: Text("texts")
        }
    }
}
