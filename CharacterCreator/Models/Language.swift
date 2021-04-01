//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift
import CoreData

///defines a flexible object to describe a language that can be learned by a character
struct Language {
	let name: String
	let isSelectable: Bool

	var spokenBy: String {
		guard let record = LanguageRecord.record(for: name) else { return "" }
		return record.spokenBy	}
	var script: String {
		guard let record = LanguageRecord.record(for: name) else { return "" }
		return record.script	}
	var isExotic: Bool {
		guard let record = LanguageRecord.record(for: name) else { return true }
		return record.isExotic	}

	init(name: String, isSelectable: Bool = false) { //}, spokenBy: String, script: String, isRare: Bool) {
		self.name 			= name
		self.isSelectable 	= isSelectable
	}
    
	enum Script: String {
		case common, draconic, dwarvish, elvish, infernal, celestial, druidic
	}
}


final
class LanguageRecord: Record, Codable {
    ///used to identify the record
    let id: String = UUID().uuidString
    ///the name of the language
    var name: String
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
        
    required //convenience
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
        self.spokenBy       = try container.decode(String.self, forKey: .spokenBy)
        self.script         = try container.decode(String.self, forKey: .script)
        self.isExotic       = try container.decodeIfPresent(Bool.self, forKey: .isExotic) ?? false
        self.isSecret       = try container.decodeIfPresent(Bool.self, forKey: .isSecret) ?? false
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
