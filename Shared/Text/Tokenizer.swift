//
//  Tokenizer.swift
//  words
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import Foundation

public enum Token {
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
    var tokens: [Token] = []
   
    let separators: CharacterSet = CharacterSet.punctuationCharacters.union(CharacterSet.whitespacesAndNewlines)
    
    let unicodeScalars = text.unicodeScalars
    var i = unicodeScalars.startIndex
    var j = 0
    while i < unicodeScalars.endIndex && j < 100 {
        j = j + 1
        // if this is a separator, add it to the token
        if (separators.contains(unicodeScalars[i])) {
            tokens.append(.separator(String(unicodeScalars[i])))
            i = unicodeScalars.index(after: i)
        }
        // advance to next separator
        var t = ""
        while i < unicodeScalars.endIndex && !(separators.contains(unicodeScalars[i]))  {
            print(">> advance token", i, unicodeScalars[i])
            t = t + String(unicodeScalars[i])
            i = unicodeScalars.index(after: i)
        }
        // we can calculate the word now
        print(">> found token", i, t, i < unicodeScalars.endIndex, j)
        tokens.append(.word(t))
    }
    return tokens
}
