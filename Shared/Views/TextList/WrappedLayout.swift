//
//  WrappedLayout.swift
//  words
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import Foundation
import SwiftUI


struct WrappedLayout: View {
    @State var tokens: [Token] = []
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
       
        return ZStack(alignment: .topLeading) {
            if tokens.count > 0 {
                ForEach(0...tokens.count - 1, id: \.self) { i in
                    let token = self.tokens[i]
                    self.item(for: token)
                        .padding([.vertical], 12)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > g.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if i == self.tokens.count - 1 {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if i == self.tokens.count - 1 {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }
        }
    }
    
    func item(for text: Token) -> some View {
        
        switch(text) {
        case .word(let word): return AnyView(HoverableToken(token: word))
        case .separator(let separator): return AnyView(Text(separator).font(.body))
        }
    
    }
}

struct HoverableToken: View {
    var token: String
    @State private var hovered: Bool = false
    @State private var selected: Bool = false
    var body: some View {
        Text(token)
            .font(.system(size: 15))
            .background(selected ? Color.secondaryBackground : Color.clear)
            .onHover {
            hovered = $0
            }.onTapGesture {
                selected = true
            }
    }
}

struct TestWrappedLayout_Previews: PreviewProvider {
    static var previews: some View {
        WrappedLayout(tokens: tokenize(demoText))
    }
}
