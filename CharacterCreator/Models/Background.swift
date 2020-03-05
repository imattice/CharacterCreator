//
//  Background.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

//a representation of the background with flexible proficiencies
struct Background {
	let name: String
	var proficiencies: [String]

	init(_ name: String, proficiencies: [String]) {
		self.name = name
		self.proficiencies = proficiencies
	}
//	init(_ name: String) {
//		self.name	= name
//		self.proficiencies = Array(BackgroundRecord.record(for: name)?.proficiencies)
//	}

	//record data retrieval methods
	func description() -> String {
		guard let record = BackgroundRecord.record(for: name) else { return "" }
		return record.detail		}
	func proficiencyOptions() -> [String]? {
		guard let record = BackgroundRecord.record(for: name) else { return [String]() }
		return Array(record.proficiencies)	}
	func initialEquipment() -> String {
		guard let record = BackgroundRecord.record(for: name) else { return "" }
		return record.equipment			}
	func startingGold() -> Int {
		guard let record = BackgroundRecord.record(for: name) else { return 0 }
		return record.gold		}
	func feature() -> String {
		guard let record = BackgroundRecord.record(for: name) else { return "" }
		return record.features }
	func languageOptions() -> [Language] {
		var results = [Language]()
		guard let record = BackgroundRecord.record(for: name) else { return results }

		for languageString in record.languages {
			let language = Language(name: languageString, isSelectable: languageString == "choice" ? true : false )
			results.append(language)
		}
		return results
	}

	static let Acolyte 	= BackgroundRecord.record(for: "acolyte")!.background()
}

@objcMembers
class BackgroundRecord: Object, Record {
	dynamic var id: String					= ""
	dynamic	var name: String				= ""
	dynamic var detail: String				= ""
	dynamic var proficiencies: List<String>	= List<String>()
	dynamic var languages: List<String>		= List<String>()
	dynamic var equipment: String			= ""
	dynamic var gold: Int					= 0
	dynamic var features: String			= ""
	dynamic var traits: List<String>		= List<String>()
	dynamic var ideals: List<String>		= List<String>()
	dynamic var bonds: List<String> 		= List<String>()
	dynamic var flaws: List<String>			= List<String>()

	static func allRecords(in realm: Realm = RealmProvider.backgroundRecords.realm) -> Results<BackgroundRecord> {
		return realm.objects(BackgroundRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.backgroundRecords.realm) -> BackgroundRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

	func background() -> Background {
		return Background(name, proficiencies: Array(proficiencies))
	}
}

