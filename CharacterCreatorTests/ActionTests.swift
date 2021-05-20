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
    
    func testBasicActionDecoding() {
        let action = """
        {
            "title": "action",
            "description": "This is an action"
        }
        """.data(using: .ascii)!
        
        XCTAssertNotNil(try? JSONDecoder().decode(Action.self, from: action))
    }

    func testRechargeCoding() {
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
        """.data(using: .ascii)!
        let dieRechargeJSON = """
        {
            "title": "d4 recharge",
            "description": "This action recharges on a long rest",
            "recharge": 4
        }
        """.data(using: .ascii)!
        
        XCTAssertTrue(try JSONDecoder().decode(Action.self, from: longRestJSON).recharge == .longRest)
        XCTAssertTrue(try JSONDecoder().decode(Action.self, from: shortRestJSON).recharge == .shortRest)
        XCTAssertTrue(try JSONDecoder().decode(Action.self, from: dieRechargeJSON).recharge == .roll(4))
        
        //MARK: Test Encoding
        let shortRest = try? JSONDecoder().decode(Action.self, from: shortRestJSON)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
       guard let data = try? encoder.encode(shortRest),
             let decoded = try? JSONDecoder().decode(Action.self, from: data)
       else { XCTFail(); return }
        
        XCTAssertTrue(decoded.recharge == .shortRest)
    }

}
