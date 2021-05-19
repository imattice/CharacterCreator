//
//  ActionTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 5/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class ActionTests: XCTestCase {

    func testRechargeDecoding() {
        let longRestJSON = """
        {
            "title": "long rest recharge",
            "description": "This action recharges on a long rest",
            "recharge": "longRest"
        }
        """.data(using: .ascii)!
        let shortRestJSON = """
        {
            "title": "short rest recharge",
            "description": "This action recharges on a short rest",
            "recharge": "shortRest"
        }
        """
        let defaultDieRecharge = """
        {
            "title": "d6 recharge",
            "description": "This action recharges the roll of a d6",
            "recharge": {
                "minRoll": 6
            }
        }
        """
        let customDieRecharge = """
        {
            "title": "d4 recharge",
            "description": "This action recharges on a long rest",
            "recharge": {
                "die": "1d4",
                "minRoll": 4
            }
        }
        """
        
        dump(try? JSONDecoder().decode(Action.self, from: longRestJSON))
        
//        XCTAssertEqual(try JSONDecoder().decode(Action.self, from: longRestJSON),   )
    }
    
}
