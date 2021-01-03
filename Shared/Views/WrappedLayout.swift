//
//  WrappedLayout.swift
//  words
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import Foundation
import SwiftUI


struct WrappedLayout: View {
    @State var tokens: [String] = []

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tokens, id: \.self) { platform in
                self.item(for: platform)
                    //.padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.tokens.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.tokens.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
//            .padding(.all, 5)
            .font(.body)
//            .background(Color.blue)
//            .foregroundColor(Color.white)
//            .cornerRadius(5)
    }
}

struct TestWrappedLayout_Previews: PreviewProvider {
    static var previews: some View {
        WrappedLayout()
    }
}
