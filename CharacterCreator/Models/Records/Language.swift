//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///defines a flexible object to describe a language that can be learned by a character
struct Language: Codable {
    let name: String
    let isSelectable: Bool
    let source: Origin
    
//    var record: LanguageRecord? = LanguageRecord.record(for: name.lowercased())()

    init(name: String, isSelectable: Bool = false, source: Origin) { //}, spokenBy: String, script: String, isRare: Bool) {
        self.name             = name
        self.isSelectable     = isSelectable
        self.source         = source
    }
    
    enum Script: String {
        case common, draconic, dwarvish, elvish, infernal, celestial, druidic
    }
}

///An object representing static data for a specific language
@objc(LanguageRecord)
final
class LanguageRecord: NSManagedObject, Record, Codable {
    ///An id for the subclass
    @NSManaged public var id: String
    ///The name of the subclass
    @NSManaged public var name: String
    ///A description of the subclass
    @NSManaged public var summary: String
    ///describes who typically speaks this language
    @NSManaged public var spokenBy: String
    ///the script that is used to write this language
    @NSManaged public var script: String
    ///determines if the language is rare
    @NSManaged public var isExotic: Bool
    ///determines if the language is only know by specific groups
    @NSManaged public var isSecret: Bool
    ///determines if the language is created by the user
//    @NSManaged public var isCustom: Bool = false
    ///returns all unique scripts used for all language records
    static var scripts: [String] {
        return all().map { $0.script }.uniques.sorted()
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
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary    = try container.decode(String.self, forKey: .summary)
        self.spokenBy       = try container.decode(String.self, forKey: .spokenBy)
        self.script         = try container.decode(String.self, forKey: .script)
        self.isExotic       = try container.decodeIfPresent(Bool.self, forKey: .isExotic) ?? false
        self.isSecret       = try container.decodeIfPresent(Bool.self, forKey: .isSecret) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(spokenBy, forKey: .spokenBy)
        try container.encode(script, forKey: .script)
        try container.encode(isExotic, forKey: .isExotic)
        try container.encode(isSecret, forKey: .isSecret)
    }
    
    enum CodingKeys: CodingKey {
        case id, name, summary, spokenBy, script, isExotic, isSecret
    }
}
