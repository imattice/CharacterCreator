//
//  RaceRecordTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 3/15/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class RaceRecordTests: XCTestCase {

//    func testStaticProperties() {
//        let testDwarf = RaceRecord(name: "dwarf", detail: "Stout and stubborn.", statModifiers: [Modifier(.increaseStat(stat: .con, value: 2), from: .race)], physicalAttributes: RaceRecord.PhysicalAttributes(age: RaceRecord.PhysicalAttributes.Age(maturity: 50, expectancy: 350), height: "4-5", weight: "150", size: .medium), speed: 25, hasDarkvision: true, alignment: .lawfulNeutral, languages: [.common, .dwarvish], features: [FeatureRecord(title: "dwarvan resilience", detail: nil, bullets: ["advantage on saving throws against poison", "resistance to poison damage"], choice: nil), FeatureRecord(title: "dwarvan combat training", detail: "proficiency with:", bullets: ["battleaxe", "handaxe", "light hammer", "warhammer"], choice: nil), FeatureRecord(title: "tool proficiency", detail: "proficiency with one of the following artisan tools:", bullets: nil, choice: ["smith's tools", "brewer's supplies", "mason's tools"]), FeatureRecord(title: "stonecunning", detail: "expertise in History regarding the origin of stonework", bullets: nil, choice: nil)], subraces: [SubraceRecord(name: "hill", detail: "keen senses, deep intuition, and remarkable resilience.", statModifiers: [Modifier(.increaseStat(stat: .wis, value: 1), from: .subrace)], features: [FeatureRecord(title: "dwarvan toughness", detail: nil, bullets: ["hit point maxium is increased by 1", "gain an additional 1 hit point each level"], choice: nil)])])
//
//        XCTAssertEqual(RaceRecord.Default.dwarf.name, testDwarf.name)
//        XCTAssertEqual(RaceRecord.Default.dwarf.detail, testDwarf.detail)
//    }
    func testDefaultRaces() {
        XCTAssertNotNil(RaceRecord.recordFor("dwarf"))
        XCTAssertNotNil(RaceRecord.recordFor("elf"))
        XCTAssertNotNil(RaceRecord.recordFor("halfling"))
        XCTAssertNotNil(RaceRecord.recordFor("human"))
        XCTAssertNotNil(RaceRecord.recordFor("dragonborn"))
        XCTAssertNotNil(RaceRecord.recordFor("gnome"))
        XCTAssertNotNil(RaceRecord.recordFor("half-elf"))
        XCTAssertNotNil(RaceRecord.recordFor("half-orc"))
        XCTAssertNotNil(RaceRecord.recordFor("tiefling"))
    }
    
    func testJSONDecodeModifier() {
        guard let modifier = RaceRecord.Default.halfling.statModifiers.first as? StatModifier else { print("no modifier in racial modifiers"); XCTFail(); return}
//        switch modifier.effect {
//        case .increaseStat(let stat, let value):
        XCTAssertEqual(modifier.value, 2)
        XCTAssertEqual(modifier.stat, Stat.dex)

//        default:
//            print("incorrect effect")
//            XCTFail()
//        }
    }
    
    func testJSONDecodePhysicalAttributes() {
        let attributes = RaceRecord.Default.dragonborn.physicalAttributes
        
        let maturity = attributes.age.maturity
        let expectancy = attributes.age.expectancy
        let height = attributes.height
        let weight = attributes.weight
        let size   = attributes.size
        
        XCTAssertEqual(maturity, 15)
        XCTAssertEqual(expectancy, 80)
        XCTAssertEqual(height, "6")
        XCTAssertEqual(weight, "250")
        XCTAssertEqual(size, .medium)
    }
    
    func testJSONDecodeAdditionalAttributes() {
        let race = RaceRecord.Default.gnome
        
        XCTAssertEqual(race.alignment, .neutralGood)
        XCTAssertEqual(race.speed, 25)
        XCTAssertEqual(race.hasDarkvision, true)
        XCTAssertEqual(race.languages, [.common, .gnomish])
    }
    
    func testJSONDecodeFeatures() {
        guard let features = RaceRecord.Default.dwarf.features else { print("nil features"); XCTFail(); return }
        let dwarvanResilience = features[0]
        let combatTraining = features[1]
        let toolProficiency = features[2]
        let stonecunning = features[3]
        
        XCTAssertEqual(dwarvanResilience, FeatureRecord(title: "dwarvan resilience",
                                                        detail: nil,
                                                        bullets: [ "advantage on saving throws against poison", "resistance to poison damage" ],
                                                        choice: nil))
        XCTAssertEqual(combatTraining, FeatureRecord(title: "dwarvan combat training",
                                                     detail: "proficiency with:",
                                                     bullets: [ "battleaxe", "handaxe", "light hammer", "warhammer"],
                                                     choice: nil))
        XCTAssertEqual(toolProficiency, FeatureRecord(title: "tool proficiency",
                                                     detail: "proficiency with one of the following artisan tools:",
                                                     bullets: nil,
                                                     choice: [ "smith's tools", "brewer's supplies", "mason's tools"]))
        XCTAssertEqual(stonecunning, FeatureRecord(title: "stonecunning",
                                                   detail: "expertise in History regarding the origin of stonework",
                                                   bullets: nil,
                                                   choice: nil))
    }
    
    func testJSONDecodeSubraces() {
        guard let subraces = RaceRecord.Default.halfling.subraces else { print("nil features"); XCTFail(); return }
        
        XCTAssertEqual(subraces[0], SubraceRecord(name: "lightfoot", detail: "sneaky and nomadic", statModifiers: [StatModifier(stat: .cha, value: 1, source: .subrace)], features: [FeatureRecord(title: "naturally stealthy", detail: "hide behind a creature that is of a larger size", bullets: nil, choice: nil)]))
    }
    
}
