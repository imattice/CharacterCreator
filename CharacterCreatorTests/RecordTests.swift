//
//  RecordTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 4/15/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
import CoreData
@testable import CharacterCreator

class RecordTests: XCTestCase {
    let testDataManager = CoreDataStack(inMemory: true)
    
    func testSaveRuleRecords() {
        //Add to core data
        do {
            try RuleRecord.save(to: testDataManager)
        } catch {
            print(error)
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<RuleRecord>(entityName: String(describing: RuleRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving RuleRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving RuleRecord")
    }
    func testSaveDiseaseRecords() {
        //Add to core data
        do {
            try DiseaseRecord.save(to: testDataManager)
        } catch {
            print(error)
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<DiseaseRecord>(entityName: String(describing: DiseaseRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving DiseaseRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving DiseaseRecord")
    }
    func testSaveTrapRecords() {
        //Add to core data
        do {
            try TrapRecord.save(to: testDataManager)
        } catch {
            print(error)
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<TrapRecord>(entityName: String(describing: TrapRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving TrapRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving TrapRecord")
    }

    func testParseFromJSON() {
        //RaceRecord
        XCTAssertNoThrow(try RaceRecord.parseFromJSON(),
                         "Parsing RaceRecord from JSON threw an error")
        XCTAssertFalse(try RaceRecord.parseFromJSON().isEmpty,
                       "Parsing RaceRecord from JSON returned an empty array")
        
        //ClassRecord
        XCTAssertNoThrow(try ClassRecord.parseFromJSON(),
                         "Parsing ClassRecord from JSON threw an error")
        XCTAssertFalse(try ClassRecord.parseFromJSON().isEmpty,
                       "Parsing ClassRecord from JSON returned an empty array")
        
        //BackgroundRecord
        XCTAssertNoThrow(try BackgroundRecord.parseFromJSON(),
                         "Parsing BackgroundRecord from JSON threw an error")
        XCTAssertFalse(try BackgroundRecord.parseFromJSON().isEmpty,
                       "Parsing BackgroundRecord from JSON returned an empty array")
        
        //ItemRecord
        XCTAssertNoThrow(try ItemRecord.parseFromJSON(),
                         "Parsing ItemRecord from JSON threw an error")
        XCTAssertFalse(try ItemRecord.parseFromJSON().isEmpty,
                       "Parsing ItemRecord from JSON returned an empty array")
        
        //WeaponRecord
        XCTAssertNoThrow(try WeaponRecord.parseFromJSON(),
                         "Parsing WeaponRecord from JSON threw an error")
        XCTAssertFalse(try WeaponRecord.parseFromJSON().isEmpty,
                       "Parsing WeaponRecord from JSON returned an empty array")
        
        //ArmorRecord
        XCTAssertNoThrow(try ArmorRecord.parseFromJSON(),
                         "Parsing ArmorRecord from JSON threw an error")
        XCTAssertFalse(try ArmorRecord.parseFromJSON().isEmpty,
                       "Parsing ArmorRecord from JSON returned an empty array")
        
        //ShieldRecord
        XCTAssertNoThrow(try ShieldRecord.parseFromJSON(),
                         "Parsing ShieldRecord from JSON threw an error")
        XCTAssertFalse(try ShieldRecord.parseFromJSON().isEmpty,
                       "Parsing ShieldRecord from JSON returned an empty array")

        //PoisonRecord
        XCTAssertNoThrow(try PoisonRecord.parseFromJSON(),
                         "Parsing PoisonRecord from JSON threw an error")
        XCTAssertFalse(try PoisonRecord.parseFromJSON().isEmpty,
                       "Parsing PoisonRecord from JSON returned an empty array")
        
        //MagicalItemRecord
        XCTAssertNoThrow(try MagicalItemRecord.parseFromJSON(),
                         "Parsing MagicalItemRecord from JSON threw an error")
        XCTAssertFalse(try MagicalItemRecord.parseFromJSON().isEmpty,
                       "Parsing MagicalItemRecord from JSON returned an empty array")
        
        //PackRecord
        XCTAssertNoThrow(try PackRecord.parseFromJSON(),
                         "Parsing PackRecord from JSON threw an error")
        XCTAssertFalse(try PackRecord.parseFromJSON().isEmpty,
                       "Parsing PackRecord from JSON returned an empty array")
        
        //ToolRecord
        XCTAssertNoThrow(try ToolRecord.parseFromJSON(),
                         "Parsing ToolRecord from JSON threw an error")
        XCTAssertFalse(try ToolRecord.parseFromJSON().isEmpty,
                       "Parsing ToolRecord from JSON returned an empty array")
        
        //SpellRecord
        XCTAssertNoThrow(try SpellRecord.parseFromJSON(),
                         "Parsing SpellRecord from JSON threw an error")
        XCTAssertFalse(try SpellRecord.parseFromJSON().isEmpty,
                       "Parsing SpellRecord from JSON returned an empty array")
        
        //CreatureRecord
        XCTAssertNoThrow(try CreatureRecord.parseFromJSON(),
                         "Parsing CreatureRecord from JSON threw an error")
        XCTAssertFalse(try CreatureRecord.parseFromJSON().isEmpty,
                       "Parsing CreatureRecord from JSON returned an empty array")
        
        //FeatRecord
        XCTAssertNoThrow(try FeatRecord.parseFromJSON(),
                         "Parsing FeatRecord from JSON threw an error")
        XCTAssertFalse(try FeatRecord.parseFromJSON().isEmpty,
                       "Parsing FeatRecord from JSON returned an empty array")
        
        //ConditionRecord
        XCTAssertNoThrow(try ConditionRecord.parseFromJSON(),
                         "Parsing ConditionRecord from JSON threw an error")
        XCTAssertFalse(try ConditionRecord.parseFromJSON().isEmpty,
                       "Parsing ConditionRecord from JSON returned an empty array")
        
        //DiseaseRecord
        XCTAssertNoThrow(try DiseaseRecord.parseFromJSON(),
                         "Parsing DiseaseRecord from JSON threw an error")
        XCTAssertFalse(try DiseaseRecord.parseFromJSON().isEmpty,
                       "Parsing DiseaseRecord from JSON returned an empty array")
        
        //RuleRecord
        XCTAssertNoThrow(try RuleRecord.parseFromJSON(),
                         "Parsing RuleRecord from JSON threw an error")
        XCTAssertFalse(try RuleRecord.parseFromJSON().isEmpty,
                       "Parsing RuleRecord from JSON returned an empty array")
    }
    

}
