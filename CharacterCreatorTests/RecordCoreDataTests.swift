//
//  RecordCoreDataTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

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
    
    func testLanguageRecordLoadData() {
        TestableRecordsDataStack.recordsManager.loadAllRecordDataIfNeeded()
        
    
    }

    func testLanguageRecordSave()  {

    }
    
    func testLanguageRecordRead() {
        
    }
}
