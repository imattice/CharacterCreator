//
//  Race.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

class Race {
    ///a reference to static attributes for this race
    let record: RaceRecord
    ///a reference to static attributes for the chosen subrace
    var subrace: SubraceRecord?
    ///the languages that the user selected for this race
    var selectedLanguages: [Language] = [Language]()
    ///the full name of the race, including the subrace
    var label: String {
        guard let subrace = subrace else { return "\(record.name)" }
        return "\(subrace.name) \(record.name)"
    }
    
    init(race: RaceRecord, subrace: SubraceRecord?) {
        self.record     = race
        self.subrace    = subrace
    }
    
    ///adds a specific language to the selectedLanguage
    func addLanguage(_ language: Language) {
        selectedLanguages.append(language)
    }
    ///removes a specific language from the selectedLanguages
    func removeLanguage(_ language: Language) {
        guard let index = selectedLanguages.firstIndex(where: { $0.name == language.name }) else { return }
        selectedLanguages.remove(at: index)
    }
}

//MARK: -Race Record
///An object representing static data for a specific race
@objc(RaceRecord)
final
class RaceRecord: NSManagedObject, Record, Codable, Identifiable {
    ///An identifier for the record
    @NSManaged public var id: String
    ///A name for the record
    @NSManaged public var name: String
    ///A description of the record
    @NSManaged public var summary: String
    ///Indicates if the race has the darkvision sense
    @NSManaged public var hasDarkvision: Bool
    ///The core data representation of the descriptive property
    @NSManaged private var cdDescriptive: String
    ///Descriptive information on average features of the race
    var descriptive: Descriptive {
        get { return (try? JSONDecoder().decode(Descriptive.self, from: Data(cdDescriptive.utf8)))!  }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdDescriptive = String(data: json, encoding:.utf8)!
           } catch { cdDescriptive = "" }
        }
    }
    ///The core data representation of the size property
    @NSManaged private var cdSize: String
    ///incdicates the size of the creature
    var size: CreatureSize {
        get { return CreatureSize(rawValue: cdSize)! }
        set { cdSize = newValue.rawValue }
    }
    ///The number of feet the creature can travel in 6 seconds
    @NSManaged public var speed: Int
    ///The core data representation of the baseLanguages property
    @NSManaged private var cdLanguages: String
    ///The languages that are natively known by this race
    var languages: [Language] {
        get { return (try? JSONDecoder().decode([Language].self, from: Data(cdLanguages.utf8)))!  }
        set {
            do {
                cdDescriptive = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdDescriptive = "" }
        }
    }
    ///The core data representation of the features property
    @NSManaged private var cdFeatures: String
    ///The gameplay features granted by this race
    var features: [Feature] {
        get { return (try? JSONDecoder().decode([Feature].self, from: Data(cdFeatures.utf8)))!  }
        set {
            do {
                cdFeatures = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdFeatures = "" }
        }
    }
    ///The core data representation of the modifiers property
    @NSManaged private var cdModifiers: String
    ///The gameplay modifiers grated by this race
    var modifiers: [Modifier] {
        get { return (try? JSONDecoder().decode([Modifier].self, from: Data(cdFeatures.utf8))) ?? [Modifier]()  }
        set {
            do {
                cdModifiers = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdModifiers = "" }
        }

    }
    ///The core data representation of the subraces property
    @NSManaged private var cdSubraceRecords: NSSet
    ///The subrace records for this race
    var subraces: [SubraceRecord] {
        get { return cdSubraceRecords.allObjects as! [SubraceRecord] }
    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id             = UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary    = try container.decode(String.self, forKey: .summary)

        let age             = try container.decode(String.self, forKey: .age)
        let alignment       = try container.decode(String.self, forKey: .alignment)
        let physique        = try container.decode(String.self, forKey: .physique)
        self.descriptive    = Descriptive(age: age, alignment: alignment, physique: physique)

        self.size           =  CreatureSize(rawValue: try container.decode(String.self, forKey: .size))!
        self.hasDarkvision  = try container.decodeIfPresent(Bool.self, forKey: .hasDarkvision) ?? false
        
        self.speed          = try container.decode(Int.self, forKey: .speed)
        
        self.modifiers      = try container.decode([AbilityScoreModifier].self, forKey: .abilityScoreModifiers)
        modifiers.forEach { $0.origin = .race }
        
        self.features       = try container.decode([Feature].self, forKey: .features)
        features.forEach { $0.origin = .race}
    
        let languageStrings = try container.decode([String].self, forKey: .baseLanguages)
        self.languages  = languageStrings.map {
            Language(name: $0, isSelectable: $0 == "choice" ? true : false, source: .race) }
        
        linkSubraceRecords(in: managedObjectContext)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(hasDarkvision, forKey: .hasDarkvision)
        try container.encode(descriptive.age, forKey: .age)
        try container.encode(descriptive.alignment, forKey: .alignment)
        try container.encode(descriptive.physique, forKey: .physique)
        try container.encode(size.rawValue, forKey: .size)
        try container.encode(languages.map { $0.name }, forKey: .baseLanguages)
        try container.encode(features, forKey: .features)
        try container.encode(modifiers, forKey: .modifiers)
    }
    
    ///Contains descriptive references of average attributes for this race
    struct Descriptive: Codable {
        ///average ages of this race
        let age: String
        ///average alignments for this race
        let alignment: String
        ///typical physical attributes for this race
        let physique: String
    }
    @objc(addCdSubraceRecordsObject:)
    @NSManaged public func addToCdSubraceRecords(_ value: SubraceRecord)

    @objc(removeCdSubraceRecordsObject:)
    @NSManaged public func removeFromCdSubraceRecords(_ value: SubraceRecord)

    @objc(addCdSubraceRecords:)
    @NSManaged public func addToCdSubraceRecords(_ values: NSSet)

    @objc(removeCdSubraceRecords:)
    @NSManaged public func removeFromCdSubraceRecords(_ values: NSSet)
    
    func linkSubraceRecords(in context: NSManagedObjectContext = CoreDataStack.shared.context) {
        let request = NSFetchRequest<SubraceRecord>(entityName: String(describing: SubraceRecord.self))
        guard let records = try? context.fetch(request),
              !records.isEmpty else { return }
        addToCdSubraceRecords(NSSet(array: records))
    }

    enum CodingKeys: CodingKey {
        case id, name, summary, age, alignment, physique, modifiers, size, speed, hasDarkvision, features, baseLanguages, abilityScoreModifiers, subraces
    }
}
