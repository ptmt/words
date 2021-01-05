//
//  TestTokenizer.swift
//  Tests iOS
//
//  Created by Dmitriy Loktev on 03.01.2021.
//

import XCTest

class TestTokenizer: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSimple() throws {
        let tokens = tokenize("Test test")
        XCTAssertEqual(tokens.count, 3)
        XCTAssertEqual(tokens.filter { $0.isWord }.count, 2)
    }

    func testPunctuation() throws {
        let tokens = tokenize("Ready? Go!")
        tokens.forEach {
            switch($0) {
            case .separator(let separator): print(separator)
            case .word(let word): print(word)
            }
        }
        XCTAssertEqual(tokens.count, 5)
        XCTAssertEqual(tokens.filter { $0.isWord }.count, 2)
    }
    
    func testPunctuationInsideWord() throws {
        let tokens = tokenize("Half-word")
        
        XCTAssertEqual(tokens.count, 3)
        XCTAssertEqual(tokens.filter { $0.isWord }.count, 2)
    }
    
    func testGerman() throws {
        let text = """
        "Was bisher Lockdown heißt, ist offenbar wenig geeignet, Infektions- und Todeszahlen zu senken. Trotzdem will die Politik die halbgare Maßnahme verlängern. Stattdessen braucht es endlich strengere, aber kurzfristigere Regeln." Kommentar v. @JankoTietz. 👏
"""
        let tokens = tokenize(text)
        tokens.forEach {
            switch($0) {
            case .separator(let separator): print(separator)
            case .word(let word): print(word)
            }
        }
        XCTAssertEqual(tokens.count, 66)
    }
    
    func testLemmas() throws {
        let text = """
        "Was bisher Lockdown heißt, ist offenbar wenig geeignet, Infektions- und Todeszahlen zu senken. Trotzdem will die Politik die halbgare Maßnahme verlängern. Stattdessen braucht es endlich strengere, aber kurzfristigere Regeln." Kommentar v. @JankoTietz. 👏
"""
        tag(text)
    }
}
