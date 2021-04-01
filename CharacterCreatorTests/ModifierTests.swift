//
//  ModifierTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/21/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class ModifierTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArrayExtensionFilter() throws {
        let modifiers: [Modifier] = [
            AbilityScoreModifier(name: .str, value: 10, adjustment: .increase, origin: .race),
            AbilityScoreModifier(name: .str, value: 10, adjustment: .increase, origin: .race),
            AbilityScoreModifier(name: .str, value: 10, adjustment: .increase, origin: .race),
            HPModifier(value: 100, isTemp: true, origin: .race) ]
        
        let noHP: [Modifier] = [
            AbilityScoreModifier(name: .str, value: 10, adjustment: .increase, origin: .race),
            AbilityScoreModifier(name: .str, value: 10, adjustment: .increase, origin: .race) ]
    
        XCTAssertTrue(modifiers.ofType(AbilityScoreModifier.self).count == 3)
        XCTAssertTrue(noHP.ofType(HPModifier.self).isEmpty)
    }
}
