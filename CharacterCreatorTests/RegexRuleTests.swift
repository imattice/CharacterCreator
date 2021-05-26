//
//  RegexRuleTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 5/25/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class RegexRuleTests: XCTestCase {

    func testRuleMatching() {
        XCTAssertEqual(RegexRules.match("10d20"), .die, "The string '10d20' does not match the die rule.")
        XCTAssertEqual(RegexRules.match("piercing damage"), .damage, "The string 'piercing damage' does not match the damage rule.")
        XCTAssertEqual(RegexRules.match("intelligence saving throw"), .savingThrow, "The string 'intelligence saving throw' does not match the saving throw rule.")
        XCTAssertEqual(RegexRules.match("1. paragraph."), .paragraphTitle, "The string '1. paragraph.' does not match the paragraph title rule.")
        XCTAssertEqual(RegexRules.match("Title."), .paragraphTitle, "The string 'Title.' does not match the paragraph title rule.")
        XCTAssertEqual(RegexRules.match("TABLE:test_table"), .dataTable, "The string 'TABLE:test_table' does not match the data table rule.")
    }
}
