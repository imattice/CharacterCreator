//
//  RecordTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 4/15/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class RecordTests: XCTestCase {

    func testRace() {
        let races = RaceRecord.all()
        
        dump(races)
    }
    
    
    
}
