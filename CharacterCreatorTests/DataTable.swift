//
//  DataTable.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 5/21/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class DataTableTests: XCTestCase {

    func testJSONParsing() {
        XCTAssertEqual(try DataTable.parseAllFromJSON().count, 24)
    }

}
