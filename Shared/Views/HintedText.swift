//
//  HintedText.swift
//  words
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import Foundation
import SwiftUI

struct HintedText: View {
    var body: some View {
        
            Text("empty")
//        } else {
//        LazyHStack(alignment: VerticalAlignment.firstTextBaseline) {
//            ForEach(0...tokens.count, id: \.self) { i in
//                Text(tokens[i])
//                }
//        }
//        }
    }
}

let text = """
If you're reading in a different language or trying a particularly challenging book, Word Wise makes it easier to quickly understand and read with fewer interruptions. Short and simple definitions automatically appear above difficult words, and you can adjust the number of hints you see with a simple slider.
"""


struct HintedText_Previews: PreviewProvider {
    static var previews: some View {
        HintedText()
    }
}
