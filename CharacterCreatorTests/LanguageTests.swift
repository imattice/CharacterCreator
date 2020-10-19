//
//  LanguageTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/18/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class LanguageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONParsing() throws {
        let languages = TEMPLanguageRecord.all()
        XCTAssertTrue(!languages.isEmpty)
        XCTAssertTrue(languages.contains { $0.name == "common" })
        XCTAssertTrue(languages.contains { $0.name == "elvish" })
        XCTAssertTrue(languages.contains { $0.name == "abyssal" })
        XCTAssertTrue(languages.contains { $0.name == "thieves' cant" })
        XCTAssertFalse(languages.filter{ $0.name == "dwarvish"}.first!.isSecret)
        XCTAssertFalse(languages.filter{ $0.name == "halfling"}.first!.isExotic)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
