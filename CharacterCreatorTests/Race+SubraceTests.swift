//
//  Race+SubraceTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/18/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class Race_SubraceTests: XCTestCase {
    func testRaceJSONParsing() throws {
        let races = try RaceRecord.parseAllFromJSON()
        XCTAssertTrue(!races.isEmpty)
        
        guard let dwarf = races.filter({ $0.name == "dwarf" }).first else { XCTFail(); return }

        XCTAssertTrue(dwarf.name == "dwarf")
        XCTAssertTrue(dwarf.description.starts(with: "Stout and stubborn, a dwarf is"))
        
        let descriptive = dwarf.descriptive
        XCTAssertTrue(descriptive.age.starts(with: "Dwarves mature at the same"))
        XCTAssertTrue(descriptive.alignment.starts(with: "Most dwarves are lawful"))
        XCTAssertTrue(descriptive.physique.starts(with: "Dwarves stand between 4 and 5 feet"))

        XCTAssertTrue(dwarf.size == .medium)
        XCTAssertTrue(dwarf.hasDarkvision == true)
        
        let modifiers = dwarf.modifiers.ofType(AbilityScoreModifier.self)
        XCTAssertTrue(modifiers.count == 1)

        let conModifier = modifiers.first!
        XCTAssertTrue(conModifier.abilityScore == .con)
        XCTAssertTrue(conModifier.value == 2)
        
        XCTAssertTrue(dwarf.features.count == 4)
        XCTAssert(dwarf.baseLanguages.contains { $0 == "common"})
        XCTAssert(dwarf.baseLanguages.contains { $0 == "dwarvish"})
    }
    
//    func testLoadRaceRecordFromCoreData() {
//        RaceRecord.loadDataIfNeeded()
//
//        let dwarf = RaceRecord.record(for: "dwarf")!
//
//        XCTAssertTrue(dwarf.name! == "dwarf")
//        XCTAssertTrue(dwarf.detail!.starts(with: "Stout and stubborn, a dwarf is"))
//
//        dump(dwarf.features)
//        let descriptive = dwarf.descriptive
//        XCTAssertTrue(descriptive!.age.starts(with: "Dwarves mature at the same"))
//        XCTAssertTrue(descriptive!.alignment.starts(with: "Most dwarves are lawful"))
//        XCTAssertTrue(descriptive!.physique.starts(with: "Dwarves stand between 4 and 5 feet"))
//
//        XCTAssertTrue(dwarf.size == .medium)
//        XCTAssertTrue(dwarf.baseLanguages!.contains("common"))
//        XCTAssertTrue(dwarf.baseLanguages!.contains("dwarvish"))
//
//        XCTAssertTrue(dwarf.features!.count == 4)
//    }
}
