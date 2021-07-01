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
//    let types: [Any] = [LanguageRecord.self, ClassRecord.self]
//
//    func testSave() {
//        types.forEach { type in
//
//            guard let record = type as? Record else { return }
//            print(record)
//        }
//    }
    
    //MARK: - Core Data Saving
    func testSaveRaceRecords() {
        //Add to core data
        do {
            try RaceRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<RaceRecord>(entityName: String(describing: RaceRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving RaceRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving RaceRecord")
    }
    func testSaveSubraceRecords() {
        //Add to core data
        do {
            try SubraceRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<SubraceRecord>(entityName: String(describing: SubraceRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving SubraceRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving SubraceRecord")
    }
    func testSaveClassRecords() {
        //Add to core data
        do {
            try ClassRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<ClassRecord>(entityName: String(describing: ClassRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving ClassRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving ClassRecord")
    }
    func testSaveSubclassRecords() {
        //Add to core data
        do {
            try SubclassRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<SubclassRecord>(entityName: String(describing: SubclassRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving SubclassRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving SubclassRecord")
    }
    func testSaveRuleRecords() {
        //Add to core data
        do {
            try RuleRecord.save(to: testDataManager)
        } catch {
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
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<TrapRecord>(entityName: String(describing: TrapRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving TrapRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving TrapRecord")
    }
    func testSaveItemRecords() {
        //Add to core data
        do {
            try ItemRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<ItemRecord>(entityName: String(describing: ItemRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving ItemRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving ItemRecord")
    }
    func testSaveWeaponRecords() {
        //Add to core data
        do {
            try WeaponRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<WeaponRecord>(entityName: String(describing: WeaponRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving WeaponRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving WeaponRecord")
    }
    func testSaveArmorRecords() {
        //Add to core data
        do {
            try ArmorRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<ArmorRecord>(entityName: String(describing: ArmorRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving ArmorRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving ArmorRecord")
    }
    func testSaveShieldRecords() {
        //Add to core data
        do {
            try ShieldRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<ShieldRecord>(entityName: String(describing: ShieldRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving ShieldRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving ShieldRecord")
    }
    func testSavePackRecords() {
        //Add to core data
        do {
            try PackRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<PackRecord>(entityName: String(describing: PackRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving PackRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving PackRecord")
    }
    func testSaveToolRecords() {
        //Add to core data
        do {
            try ToolRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<ToolRecord>(entityName: String(describing: ToolRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving ToolRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving ToolRecord")
    }
    func testSavePoisonRecords() {
        //Add to core data
        do {
            try PoisonRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<PoisonRecord>(entityName: String(describing: PoisonRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving PoisonRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving PoisonRecord")
    }
    func testSaveMagicItemRecords() {
        //Add to core data
        do {
            try MagicItemRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<MagicItemRecord>(entityName: String(describing: MagicItemRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving MagicItemRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving MagicItemRecord")
    }
    func testSaveBackgroundRecords() {
        //Add to core data
        do {
            try BackgroundRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<BackgroundRecord>(entityName: String(describing: BackgroundRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving BackgroundRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving BackgroundRecord")
    }
    func testSaveLanguageRecords() {
        //Add to core data
        do {
            try LanguageRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<LanguageRecord>(entityName: String(describing: LanguageRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving LanguageRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving LanguageRecord")
    }
    func testSaveSpellRecords() {
        //Add to core data
        do {
            try SpellRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<SpellRecord>(entityName: String(describing: SpellRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving SpellRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving SpellRecord")
    }
    func testSaveCreatureRecords() {
        //Add to core data
        do {
            try CreatureRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<CreatureRecord>(entityName: String(describing: CreatureRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving CreatureRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving CreatureRecord")
    }
    func testSaveFeatRecords() {
        //Add to core data
        do {
            try FeatRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<FeatRecord>(entityName: String(describing: FeatRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving FeatRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving FeatRecord")
    }
    func testSaveConditionRecords() {
        //Add to core data
        do {
            try ConditionRecord.save(to: testDataManager)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
        
        //Fetch the saved data
        let request = NSFetchRequest<ConditionRecord>(entityName: String(describing: ConditionRecord.self))
        let records = try? testDataManager.context.fetch(request)
        
        //Validate records
        XCTAssertNotNil(records, "Fetched nil results after saving ConditionRecord")
        XCTAssertTrue(records!.count > 0, "Fetched empty array after saving ConditionRecord")
    }


    
    //MARK: - Relationship Linking
    func testSubraceLinking() {
        //Add to core data
        do {
            try RaceRecord.save(to: testDataManager)
            let request = NSFetchRequest<RaceRecord>(entityName: String(describing: RaceRecord.self))
            let records = try testDataManager.context.fetch(request)
            guard let record = records.first else { XCTFail("failed to fetch record while linking subraces"); return }
            
            XCTAssertTrue(record.subraces.isEmpty)
            
            try SubraceRecord.save(to: testDataManager)
            record.linkSubraceRecords(in: testDataManager.context)

            XCTAssertFalse(record.subraces.isEmpty)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
    }
    func testRaceLinking() {
        //Add to core data
        do {
            try SubraceRecord.save(to: testDataManager)
            let request = NSFetchRequest<SubraceRecord>(entityName: String(describing: SubraceRecord.self))
            let records = try testDataManager.context.fetch(request)
            guard let record = records.first else { XCTFail("failed to fetch record while linking subraces"); return }
            //A parent record does not exist because the RaceRecords have not been saved
            XCTAssertNil(record.parentRecord)
            //Save the RaceRecords
            try RaceRecord.save(to: testDataManager)
            //The RaceRecord initializer will create an inverse relationship with its subraces
            XCTAssertNotNil(record.parentRecord)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
    }
    
    func testClassLinking() {
        //Add to core data
        do {
            try SubclassRecord.save(to: testDataManager)
            let request = NSFetchRequest<SubclassRecord>(entityName: String(describing: SubclassRecord.self))
            let records = try testDataManager.context.fetch(request)
            guard let record = records.first else { XCTFail("failed to fetch record while linking subraces"); return }
            //A parent record does not exist because the ClassRecords have not been saved
            XCTAssertNil(record.parentRecord)
            //Save the ClassRecords
            try ClassRecord.save(to: testDataManager)
            //The ClassRecord initializer will create an inverse relationship with its subclasses
            XCTAssertNotNil(record.parentRecord)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
    }

    func testSubclassLinking() {
        //Add to core data
        do {
            try ClassRecord.save(to: testDataManager)
            let request = NSFetchRequest<ClassRecord>(entityName: String(describing: ClassRecord.self))
            let records = try testDataManager.context.fetch(request)
            guard let record = records.first else { XCTFail("failed to fetch record while linking subclasses"); return }
            
            XCTAssertTrue(record.subclasses.isEmpty)
            
            try SubclassRecord.save(to: testDataManager)
            record.linkSubclassRecords(in: testDataManager.context)

            XCTAssertFalse(record.subclasses.isEmpty)
        } catch {
            XCTFail("There was an error while saving: \(error)")
        }
    }
    
    //MARK: - Test Data Retrieval
    func testRaceRecordRetrieval() {
        ///The specific record that will be fetched during the test
        let recordName: String = "dwarf"
        typealias RecordType = RaceRecord
        
        do {
            try RecordType.save(to: testDataManager)
        }
        catch { XCTFail("There was an error while saving: \(error)") }
        
        XCTAssertFalse(RecordType.all(in: testDataManager.context).isEmpty, "Failed to retrieve all RaceRecords")
        XCTAssertNotNil(RaceRecord.record(for: recordName, in: testDataManager.context), "Failed to retrieve record for \(recordName)")
    }


    //MARK: - JSON Parsing
    func testParseRaceRecordFromJSON() {
        XCTAssertNoThrow(try RaceRecord.parseFromJSON(),
                         "Parsing RaceRecord from JSON threw an error")
        XCTAssertFalse(try RaceRecord.parseFromJSON().isEmpty,
                       "Parsing RaceRecord from JSON returned an empty array")
    }
    func testParseSubraceRecordFromJSON() {
        XCTAssertNoThrow(try SubraceRecord.parseFromJSON(),
                         "Parsing SubraceRecord from JSON threw an error")
        XCTAssertFalse(try SubraceRecord.parseFromJSON().isEmpty,
                       "Parsing SubraceRecord from JSON returned an empty array")
    }
    func testParseClassRecordFromJSON() {
        XCTAssertNoThrow(try ClassRecord.parseFromJSON(),
                         "Parsing ClassRecord from JSON threw an error")
        XCTAssertFalse(try ClassRecord.parseFromJSON().isEmpty,
                       "Parsing ClassRecord from JSON returned an empty array")
    }
    func testParseSubclassRecordFromJSON() {
        XCTAssertNoThrow(try SubclassRecord.parseFromJSON(),
                         "Parsing SubclassRecord from JSON threw an error")
        XCTAssertFalse(try SubclassRecord.parseFromJSON().isEmpty,
                       "Parsing SubclassRecord from JSON returned an empty array")
    }
    func testParseBackgroundRecordFromJSON() {
        XCTAssertNoThrow(try BackgroundRecord.parseFromJSON(),
                         "Parsing BackgroundRecord from JSON threw an error")
        XCTAssertFalse(try BackgroundRecord.parseFromJSON().isEmpty,
                       "Parsing BackgroundRecord from JSON returned an empty array")
    }
    func testParseItemRecordFromJSON() {
        XCTAssertNoThrow(try ItemRecord.parseFromJSON(),
                         "Parsing ItemRecord from JSON threw an error")
        XCTAssertFalse(try ItemRecord.parseFromJSON().isEmpty,
                       "Parsing ItemRecord from JSON returned an empty array")
    }
    func testParseWeaponRecordFromJSON() {
        XCTAssertNoThrow(try WeaponRecord.parseFromJSON(),
                         "Parsing WeaponRecord from JSON threw an error")
        XCTAssertFalse(try WeaponRecord.parseFromJSON().isEmpty,
                       "Parsing WeaponRecord from JSON returned an empty array")
    }
    func testParseArmorRecordFromJSON() {
        XCTAssertNoThrow(try ArmorRecord.parseFromJSON(),
                         "Parsing ArmorRecord from JSON threw an error")
        XCTAssertFalse(try ArmorRecord.parseFromJSON().isEmpty,
                       "Parsing ArmorRecord from JSON returned an empty array")
    }
    func testParseShieldRecordFromJSON() {
        XCTAssertNoThrow(try ShieldRecord.parseFromJSON(),
                         "Parsing ShieldRecord from JSON threw an error")
        XCTAssertFalse(try ShieldRecord.parseFromJSON().isEmpty,
                       "Parsing ShieldRecord from JSON returned an empty array")
    }
    func testParsePoisonRecordFromJSON() {
        XCTAssertNoThrow(try PoisonRecord.parseFromJSON(),
                         "Parsing PoisonRecord from JSON threw an error")
        XCTAssertFalse(try PoisonRecord.parseFromJSON().isEmpty,
                       "Parsing PoisonRecord from JSON returned an empty array")
    }
    func testParseMagicalItemRecordFromJSON() {
        XCTAssertNoThrow(try MagicItemRecord.parseFromJSON(),
                         "Parsing MagicalItemRecord from JSON threw an error")
        XCTAssertFalse(try MagicItemRecord.parseFromJSON().isEmpty,
                       "Parsing MagicalItemRecord from JSON returned an empty array")
    }
    func testParsePackRecordFromJSON() {
        XCTAssertNoThrow(try PackRecord.parseFromJSON(),
                         "Parsing PackRecord from JSON threw an error")
        XCTAssertFalse(try PackRecord.parseFromJSON().isEmpty,
                       "Parsing PackRecord from JSON returned an empty array")
    }
    func testParseToolRecordFromJSON() {
        XCTAssertNoThrow(try ToolRecord.parseFromJSON(),
                         "Parsing ToolRecord from JSON threw an error")
        XCTAssertFalse(try ToolRecord.parseFromJSON().isEmpty,
                       "Parsing ToolRecord from JSON returned an empty array")
    }
    func testParseSpellRecordFromJSON() {
        XCTAssertNoThrow(try SpellRecord.parseFromJSON(),
                         "Parsing SpellRecord from JSON threw an error")
        XCTAssertFalse(try SpellRecord.parseFromJSON().isEmpty,
                       "Parsing SpellRecord from JSON returned an empty array")
    }
    func testParseCreatureRecordFromJSON() {
        XCTAssertNoThrow(try CreatureRecord.parseFromJSON(),
                         "Parsing CreatureRecord from JSON threw an error")
        XCTAssertFalse(try CreatureRecord.parseFromJSON().isEmpty,
                       "Parsing CreatureRecord from JSON returned an empty array")
    }
    func testParseFeatRecordFromJSON() {
        XCTAssertNoThrow(try FeatRecord.parseFromJSON(),
                         "Parsing FeatRecord from JSON threw an error")
        XCTAssertFalse(try FeatRecord.parseFromJSON().isEmpty,
                       "Parsing FeatRecord from JSON returned an empty array")
    }
    func testParseConditionRecordFromJSON() {
        XCTAssertNoThrow(try ConditionRecord.parseFromJSON(),
                         "Parsing ConditionRecord from JSON threw an error")
        XCTAssertFalse(try ConditionRecord.parseFromJSON().isEmpty,
                       "Parsing ConditionRecord from JSON returned an empty array")
    }
    func testParseDiseaseRecordFromJSON() {
        XCTAssertNoThrow(try DiseaseRecord.parseFromJSON(),
                         "Parsing DiseaseRecord from JSON threw an error")
        XCTAssertFalse(try DiseaseRecord.parseFromJSON().isEmpty,
                       "Parsing DiseaseRecord from JSON returned an empty array")
    }
    func testParseRuleRecordFromJSON() {
        XCTAssertNoThrow(try RuleRecord.parseFromJSON(),
                         "Parsing RuleRecord from JSON threw an error")
        XCTAssertFalse(try RuleRecord.parseFromJSON().isEmpty,
                       "Parsing RuleRecord from JSON returned an empty array")
    }
    func testParseLanguageRecordFromJSON() {
        XCTAssertNoThrow(try LanguageRecord.parseFromJSON(),
                         "Parsing LanguageRecord from JSON threw an error")
        XCTAssertFalse(try LanguageRecord.parseFromJSON().isEmpty,
                       "Parsing LanguageRecord from JSON returned an empty array")
    }

}
