//
//  Tagger.swift
//  words
//
//  Created by Dmitriy Loktev on 04.01.2021.
//

import Foundation
import NaturalLanguage

func tag(_ text: String) {
    let tagger = NLTagger(tagSchemes: [.lemma])
    tagger.string = text
    let orthography = NSOrthography.defaultOrthography(forLanguage: "de")
    tagger.setOrthography(orthography, range: text.startIndex..<text.endIndex)
    tagger.setLanguage(.german, range: text.startIndex..<text.endIndex)
    let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
    tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma, options: options) { tag, tokenRange in
        print("\(text[tokenRange]): \(tag?.rawValue ?? "NO LEMMA")")
        return true
    }
}
