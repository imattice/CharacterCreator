//
//  DieTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 5/10/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class DieTests: XCTestCase {

    func testInitializer() {
        XCTAssertNotNil(Die(from: "1d8"), "Die object cannot be initialized for test string '1d8'")
        XCTAssertNotNil(Die(from: "10d12"), "Die object cannot be initialized for test string '10d12'")
        XCTAssertNil(Die(from: "Invalid"), "Die object cannot be created from an invalid string")
        XCTAssertNil(Die(from: "Invalid1d8Invalid"), "Die object cannot be created from an invalid string")
    }
}
