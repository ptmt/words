//
//  Tokenizer.swift
//  words
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import Foundation
import NaturalLanguage

public enum Token: Hashable {
    case word(String), separator(String)
    
    var isSeparator: Bool {
        switch(self) {
        case .separator(_): return true
        case .word(_): return false
        }
    }
    var isWord: Bool {
        switch(self) {
        case .separator(_): return false
        case .word(_): return true
        }
    }
}

public func tokenize(_ text: String) -> [Token] {
    let tokenizer = NLTokenizer(unit: .word)
    tokenizer.setLanguage(.german)
    tokenizer.string = text
    var tokens: [Token] = []
    var i = text.unicodeScalars.startIndex
    
    tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { tokenRange, _ in
        if (tokenRange.lowerBound > i) {
            tokens.append(.separator(String(text[i..<tokenRange.lowerBound])))
        }
        print(text[tokenRange])
        tokens.append(.word(String(text[tokenRange])))
        i = tokenRange.upperBound
        return true
    }
    
    return tokens
}
// TODO: use NLP tokenizer
public func tokenize2(_ text: String) -> [Token] {
    var tokens: [Token] = []
   
    let separators: CharacterSet = CharacterSet.punctuationCharacters.union(CharacterSet.whitespacesAndNewlines)
    
    let unicodeScalars = text.unicodeScalars
    var i = unicodeScalars.startIndex
    var j = 0 // safe switch against endless loop
    while i < unicodeScalars.endIndex && j < 10000 {
        j = j + 1
        
        // advance to next separator
        var t = ""
        while i < unicodeScalars.endIndex && !(separators.contains(unicodeScalars[i]))  {
            t = t + String(unicodeScalars[i])
            i = unicodeScalars.index(after: i)
        }
        // we can calculate the word now
        if (!t.isEmpty) {
            tokens.append(.word(t))
        }
        
        // if this is a separator, add it to the token
        if (i < unicodeScalars.endIndex && separators.contains(unicodeScalars[i])) {
            tokens.append(.separator(String(unicodeScalars[i])))
            i = unicodeScalars.index(after: i)
        }
    }
    return tokens
}
