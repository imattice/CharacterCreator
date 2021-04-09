//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation

///defines a flexible object to describe a language that can be learned by a character
struct Language {
    let name: String
    let isSelectable: Bool
    let source: Origin
    
    var record: LanguageRecord? = LanguageRecord.record(for: name.lowercased())()

    var spokenBy: String {
        guard let record = LanguageRecord.record(for: name) else { return "" }
        return record.spokenBy    }
    var script: String {
        guard let record = LanguageRecord.record(for: name) else { return "" }
        return record.script    }
    var isExotic: Bool {
        guard let record = LanguageRecord.record(for: name) else { return true }
        return record.isExotic    }

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
struct LanguageRecord: Record, Customizable, Codable {
    ///used to identify the record
    let id: String = UUID().uuidString
    ///the name of the language
    let name: String
    ///a  paragraph containing descriptive details about the language
    let description: String
    ///describes who typically speaks this language
    let spokenBy: String
    ///the script that is used to write this language
    let script: String
    ///determines if the language is rare
    let isExotic: Bool
    ///determines if the language is only know by specific groups
    let isSecret: Bool
    ///determines if the language is created by the user
    let isCustom: Bool = false
    ///returns all unique scripts used for all language records
    static var scripts: [String] {
        return all().map { $0.script }.uniques.sorted()
    }
        
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
        self.spokenBy       = try container.decode(String.self, forKey: .spokenBy)
        self.script         = try container.decode(String.self, forKey: .script)
        self.isExotic       = try container.decodeIfPresent(Bool.self, forKey: .isExotic) ?? false
        self.isSecret       = try container.decodeIfPresent(Bool.self, forKey: .isSecret) ?? false
    }
    init(name: String, description: String, spokenBy: String, script: String, isExotic: Bool, isSecret: Bool, isCustom: Bool = false) {

        self.name = name
        self.description = description
        self.spokenBy = spokenBy
        self.script = script
        self.isExotic = isExotic
        self.isSecret = isSecret
    }
}



//MARK: -Old Core Data Implementation
//final
//class LanguageRecord: NSManagedObject, Record, Decodable {
//    required convenience
//    init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
//          throw JSONError.missingManagedObjectContextForDecoder }
//
//        self.init(context: context)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = UUID().uuidString
//        self.name = try container.decode(String.self, forKey: .name)
//        self.spokenBy = try container.decode(String.self, forKey: .spokenBy)
//        self.script = try container.decode(String.self, forKey: .script)
//        self.isExotic = try container.decodeIfPresent(Bool.self, forKey: .isExotic) ?? false
//        self.isSecret = try container.decodeIfPresent(Bool.self, forKey: .isSecret) ?? false
//    }
//    enum CodingKeys: CodingKey {
//        case id, isExotic, isSecret, name, script, spokenBy
//    }
//}
