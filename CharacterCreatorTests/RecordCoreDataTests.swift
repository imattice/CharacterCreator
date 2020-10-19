//
//  RecordCoreDataTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest

class RecordCoreDataTests: XCTestCase {
    var dataStack: TestableRecordsDataStack!

    override func setUpWithError() throws {
        super.setUp()
        dataStack = TestableRecordsDataStack()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        dataStack = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
