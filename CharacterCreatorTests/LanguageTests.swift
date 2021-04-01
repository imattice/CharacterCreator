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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONParsing() throws {
        let languages = try LanguageRecord.parseAllFromJSON()
        XCTAssertTrue(!languages.isEmpty)
        XCTAssertTrue(languages.contains { $0.name == "common" })
        XCTAssertTrue(languages.contains { $0.name == "elvish" })
        XCTAssertTrue(languages.contains { $0.name == "abyssal" })
        XCTAssertTrue(languages.contains { $0.name == "thieves' cant" })
        XCTAssertFalse(languages.filter{ $0.name == "dwarvish"}.first!.isSecret)
        XCTAssertFalse(languages.filter{ $0.name == "halfling"}.first!.isExotic)
    }
    
    func testScripts() {
        let scripts = LanguageRecord.scripts
        
        XCTAssert(scripts.contains("infernal"))
        XCTAssert(scripts.contains("common"))
        XCTAssert(scripts.contains("none"))
    }
    
    func testSaveCustom() {
        let record = LanguageRecord(name: "English", description: "Spoken in the real world", spokenBy: "humans", script: "roman", isExotic: false, isSecret: false)
        try? LanguageRecord.saveCustom(record)
        
        let record2 = LanguageRecord(name: "Spanish", description: "Also psoken in the real world", spokenBy: "humans", script: "roman", isExotic: false, isSecret: false)

        try? LanguageRecord.saveCustom(record2)
        
        dump(try? LanguageRecord.allCustom())
    }
}
