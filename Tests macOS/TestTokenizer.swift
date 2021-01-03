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

    func testTokenizer() throws {
        let tokens = tokenize("Test test")
        XCTAssertEqual(tokens.count, 3)
        XCTAssertEqual(tokens.filter { $0.isWord }.count, 2)
    }

}
