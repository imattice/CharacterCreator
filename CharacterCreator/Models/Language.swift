//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

struct Language {
	let name: String
	let spokenBy: String
	let script: String
	let isRare: Bool
	var isSelectable: Bool

	enum Script: String {
		case common, draconic, dwarvish, elvish, infernal, celestial, druidic
	}

	init(name: String, spokenBy: String, script: String, isRare: Bool) {
		self.name 			= name
		self.spokenBy 		= spokenBy
		self.script 		= script
		self.isRare			= isRare
		self.isSelectable 	= false
	}
}

extension Language {
	static let Common 			= LanguageRecord.record(for: "common")!.language()
	static let Draconic 		= LanguageRecord.record(for: "draconic")!.language()
	static let Dwarvish 		= LanguageRecord.record(for: "dwarvish")!.language()
	static let Elven		 	= LanguageRecord.record(for: "elven")!.language()

	static let Giant 			= LanguageRecord.record(for: "giant")!.language()
	static let Gnomish 			= LanguageRecord.record(for: "gnomish")!.language()
	static let Goblin			= LanguageRecord.record(for: "goblin")!.language()
	static let Halfling 		= LanguageRecord.record(for: "halfling")!.language()
	static let Abyssal 			= LanguageRecord.record(for: "abyssal")!.language()
	static let Celestial 		= LanguageRecord.record(for: "celestial")!.language()
	static let DeepSpeech 		= LanguageRecord.record(for: "deep speech")!.language()
	static let Infernal 		= LanguageRecord.record(for: "infernal")!.language()
	static let Orc				= LanguageRecord.record(for: "orc")!.language()
	static let Undercommon 		= LanguageRecord.record(for: "undercommon")!.language()
}

@objcMembers
class LanguageRecord : Object {
	dynamic var id: String 			= UUID().uuidString
	dynamic var name: String		= ""
	dynamic var spokenBy: String	= ""
	dynamic var script: String		= ""
	dynamic var isRare: Bool		= false

	static func allRecords(in realm: Realm = RealmProvider.languageRecords.realm) -> Results<LanguageRecord> {
		return realm.objects(LanguageRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.languageRecords.realm) -> LanguageRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

	func language() -> Language {
		return Language(name: name, spokenBy: spokenBy, script: script, isRare: isRare)
	}
}
