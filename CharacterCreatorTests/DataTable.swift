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
        XCTAssertNoThrow(try DataTable.parseFromJSON(),
                         "Parsing DataTable from JSON threw an error")
        XCTAssertFalse(try DataTable.parseFromJSON().isEmpty,
                       "Parsing DataTable from JSON returned an empty array")
    }

}
