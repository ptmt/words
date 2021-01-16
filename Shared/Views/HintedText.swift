//
//  HintedText.swift
//  words
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import Foundation
import SwiftUI

struct HintedText: View {
    @State var title: String
    var updatedAt: String
    @State var text: String
    @State var isEditing: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if (isEditing) {
                    TextField("Title", text: $title).font(.largeTitle).padding(.vertical, 4)
                    TextEditor(text: $text).font(.system(size: 15))
                } else {
                    Text(title).font(.largeTitle).padding(.vertical, 4)
                    Text(updatedAt).foregroundColor(.secondary)
                    WrappedLayout(tokens: tokenize(text))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(14.0)
        }
        .padding(30)
        // .background(Color.gray)
        .toolbar {
            if (isEditing) {
                Button("Save") {
                    isEditing = true
                }
            } else {
                Button("Edit") {
                    isEditing = true
                }
                Button("Delete") {
                    isEditing = true
                }
            }
        }
    }
}

let demoText = """
If you're reading in a different language or trying a particularly challenging book, Word Wise makes it easier to quickly understand and read with fewer interruptions. Short and simple definitions automatically appear above difficult words, and you can adjust the number of hints you see with a simple slider.
"""

let demoText2 = """
»Was bisher Lockdown heißt, ist offenbar wenig geeignet, Infektions- und Todeszahlen zu senken. Trotzdem will die Politik die halbgare Maßnahme verlängern. Stattdessen braucht es endlich strengere, aber kurzfristigere Regeln.« Kommentar v.
@JankoTietz
. 👏
"""


struct HintedText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HintedText(title: "Spiegel: Tweet",
                       updatedAt: "just now",
                       text: demoText2)
            HintedText(title: "Spiegel: Tweet",
                       updatedAt: "just now",
                       text: demoText2,
                       isEditing: true)
        }.padding().background(Color.gray)
    }
}
