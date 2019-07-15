//
//  Background.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

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
		return Background(name)
	}
}

struct Background {
	let name: String

	init(_ name: String) {
		self.name = name
	}

	func proficiencies() -> [String]? {
		guard let dict = backgroundData[name] as? [String: Any] else { print("could not initialize background data"); return nil }
		guard let skills = dict["skills"] as? [String] else { print("Could not get skills froom \(name)"); return nil }

		return skills
	}
	func description() -> String {
		guard let backgroundDict = backgroundData[name] as? [String : Any],
			let reputationDict = backgroundDict["reputation"] as? [String : String],
			let description = reputationDict.values.first
		else { print("could not initialize data for background \(name)"); return "" }

		return description
	}
	func languages() -> [Language] {
		guard let backgroundDict = backgroundData[name] as? [String : Any],
			let languages = backgroundDict["languages"] as? [String] else { return [Language]()}

		var result = [Language]()
		for language in languages {
			if let record = LanguageRecord.record(for: language) {
				result.append( record.language() )
			}
			if language == "choice" {
				var languageChoice = Language(name: "choice", spokenBy: "-", script: "-", isRare: false)
					languageChoice.isSelectable	= true
				result.append(languageChoice)
			}

		}
		return result
	}

	static let Acolyte 	= Background("acolyte")
	static let Criminal = Background("criminal")
	static let FolkHero = Background("folk hero")
	static let Noble 	= Background("noble")
	static let Sage 	= Background("sage")
	static let Soldier 	= Background("acolyte")
}
