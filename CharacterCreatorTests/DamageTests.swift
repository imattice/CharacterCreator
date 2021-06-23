//
//  DamageTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 6/25/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class DamageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringPatternMatching() {
		let missingMultiplier 		= "d3 force"
		let missingValue  			= "13 force"
		let incorrectDamageType		= " 1d6 normal"
		let correctDamagePattern	= "10d12 fire"

		let missingMultiplierResult 	= try? Damage(missingMultiplier)
		let missingValueResult			= try? Damage(missingValue)
		let incorrectDamageTypeResult	= try? Damage(incorrectDamageType)
		let correctDamagePatternResult	= try? Damage(correctDamagePattern)

		XCTAssertNil(missingMultiplierResult)
		XCTAssertNil(missingValueResult)
		XCTAssertNil(incorrectDamageTypeResult)
		XCTAssertEqual(correctDamagePatternResult!, Damage(multiplier: 10, type: .fire, value: 12))
    }
}
