//
//  TextListRow.swift
//  words
//
//  Created by Dmitriy Loktev on 16.01.2021.
//

import Foundation
import SwiftUI

struct TextRowView: View {
    var text: WText
    var body: some View {
        VStack(alignment: .leading) {
            if let title = text.title {
                Text(title).font(.headline)
            }
            HStack {
                Text("\(text.updatedAt!, formatter: itemFormatter)").opacity(0.75)
                if let link = text.link {
                    Text(link.absoluteString).foregroundColor(.secondary)
                }
            }
            Text(text.content?.prefix(100) ?? "").lineLimit(1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct TextRowView_Previews: PreviewProvider {
    static func text() -> WText {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let text = WText(context: viewContext)
        text.title = "The Father of Infinity and Modern Mathematics: Georg Cantor"
        text.createdAt = Date()
        text.link = URL(string: "https://ali.medium.com/the-father-of-infinity-and-modern-mathematics-georg-cantor-93beb245756e")
        text.content = "“In mathematics the art of proposing a question must be held of higher value than solving it.” This analysis belongs to the undervalued genius of his time, Georg Cantor."
        try? viewContext.save()
        return text
    }
    static var previews: some View {
        //Text(text().content ?? "")
        TextRowView(text: text()).previewLayout(.fixed(width: 300, height: 100))
    }
}
