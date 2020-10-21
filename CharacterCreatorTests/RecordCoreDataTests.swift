//
//  RecordCoreDataTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
import CoreData
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
        LanguageRecord.loadDataIfNeeded()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LanguageRecord")
        let fetch = try? RecordDataManager.shared.managedContext.fetch(request)
        
        XCTAssertFalse(fetch!.isEmpty)
        XCTAssert(fetch?.count == 18)
    }
    
    func testLangaugeRecordAll() {
        let all = LanguageRecord.all()
        
        XCTAssert(all.count == 18)
    }
    
    func testLanguageRecordSave()  {

    }
    
    func testLanguageRecordRead() {
        LanguageRecord.loadDataIfNeeded()
        
        let common = LanguageRecord.record(for: "common")
        
        XCTAssertNotNil(common)
        XCTAssertTrue(common!.name == "common")
        
        let matches = LanguageRecord.records(matching: "common")
        
        XCTAssertNotNil(matches)
        XCTAssertTrue(matches.count == 2)
        XCTAssertTrue(matches.contains { $0.name == "common" })
        XCTAssertTrue(matches.contains { $0.name == "undercommon" })
    }
}
