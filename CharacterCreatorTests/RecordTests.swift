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
    func testRace() throws {
        let races = try RaceRecord.parseAllFromJSON()
        XCTAssertFalse(races.isEmpty)
        
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
        XCTAssertTrue(conModifier.stat == .con)
        XCTAssertTrue(conModifier.value == 2)
        
        XCTAssertTrue(dwarf.features.count == 4)
        XCTAssert(dwarf.baseLanguages.contains { $0.name == "common"})
        XCTAssert(dwarf.baseLanguages.contains { $0.name == "dwarvish"})
        
        guard let halfElf = races.filter({ $0.name == "half-elf" }).first else { XCTFail(); return }
        
        XCTAssert(halfElf.baseLanguages.contains { $0.name == "elvish"})
        XCTAssert(halfElf.baseLanguages.contains { $0.name == "common"})
        XCTAssert(halfElf.baseLanguages.contains { $0.name == "choice"})
        
        guard let human = races.filter({ $0.name == "human" }).first else { XCTFail(); return }
        
        XCTAssert(human.baseLanguages.contains { $0.name == "choice"})
        
        XCTAssertEqual(races.count, 9)
    }
    
    func testSingularInstanceJSON() {
        let data = """
            [{
                    "name": "dwarf",
                    "description": "Stout and stubborn, a dwarf is known for their tenacity with metalwork and ores.  They can often be found in deep recesses of mountains, underground and generally keeping to themselves.",
                    "age": "Dwarves mature at the same rate as humans, but they’re considered young until they reach the age of 50. On average, they live about 350 years.",
                    "alignment": "Most dwarves are lawful, believing firmly in the benefits of a well-­‐‑ordered society. They tend toward good as well, with a strong sense of fair play and a belief that everyone deserves to share in the benefits of a just order.",
                    "physique": "Dwarves stand between 4 and 5 feet tall and average about 150 pounds.",
                    "size": "medium",
                    "hasDarkvision": true,
                    "speed": 30,
                    "features": [{
                            "title": "Dwarven Resilience",
                            "description": "You have advantage on saving throws against poison, and you have resistance against poison damage."
                        },
                        {
                            "title": "Dwarven Combat Training",
                            "description": "You have proficiency with the battleaxe, handaxe, light hammer, and warhammer."
                        },
                        {
                            "title": "Tool Proficiency",
                            "description": "You gain proficiency with the artisan’s tools of your choice: smith’s tools, brewer’s supplies, or mason’s tools.",
                            "options": ["smith’s tools", "brewer’s supplies", "mason’s tools"]
                        },
                        {
                            "title": "Stonecunning",
                            "description": "Whenever you make an Intelligence (History) check related to the origin of stonework, you are considered proficient in the History skill and add double your proficiency bonus to the check, instead of your normal proficiency bonus."
                        }
                    ],
                    "abilityScoreModifiers": [{
                        "stat": "con",
                        "value": 2,
                        "origin": "race"
                    }],
                    "baseLanguages": [
                        "common",
                        "dwarvish"
                    ],
                    "subraces": [{
                        "name": "hill dwarf",
                        "description": "As a hill dwarf, you have keen senses, deep intuition, and remarkable resilience.",
                        "abilityScoreModifiers": {
                            "wis": 1
                        },
                        "features": [{
                            "title": "Dwarven Toughness",
                            "description": "Your hit point maximum increases by 1, and it increases by 1 every time you gain a level."
                        }]
                    }]
                }]
        """.data(using: .utf8)!
        
        do {
            let record = try JSONDecoder().decode([RaceRecord].self, from: data)
            //dump(record)
            XCTAssertFalse(record.isEmpty)
        }
        catch {
            print("Error: \(error)")
        }

    }
}
