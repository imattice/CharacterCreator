//
//  StringExtensionTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 4/16/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest

@testable import CharacterCreator

class StringExtensionTests: XCTestCase {

    func testRanges() {
        let string = "This is referring to a 1d4, 5d6, an 100d20 die rolls.  There are also 5d2 die rolls included in this example."
        let string2 = "Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.\nThe spell damages objects in the area and ignites flammable objects that aren’t being worn or carried."
        
        let ranges = string.ranges(of: "[0-9]+d[0-9]+", options: .regularExpression)
        let ranges2 = string2.ranges(of: "[0-9]+d[0-9]+", options: .regularExpression)
        
        dump(ranges2)
        
        XCTAssertEqual(string[ranges[0]], "1d4")
        
    }

}
