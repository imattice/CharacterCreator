//
//  Pack.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/3/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PackRecord: Object {
	dynamic var id: String				= UUID().uuidString
	dynamic var name: String			= ""
	let contents: List<String> 			= List<String>()

	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<PackRecord> {
		return realm.objects(PackRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> PackRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

//	func pack() -> Pack {
//		return Language(name: name, spokenBy: spokenBy, script: script, isRare: isRare)
//	}
}

class Pack: Item {
	let contents: [String]

	init?(pack name: String) {
		guard let packDict = packDict[name.lowercased()],
		let contents = packDict["contents"] else { return nil }

		self.contents	= contents

		super.init(name)
	}
}

extension Pack {
	static let Priest 		= Pack(pack: "priest's pack")!
	static let Explorer 	= Pack(pack: "explorer's pack")!
	static let Dungeoneer 	= Pack(pack: "dungeoneer's pack")!
	static let Diplomat 	= Pack(pack: "diplomat's pack")!
	static let Burgler 		= Pack(pack: "burglar's pack")!
	static let Entertainer	= Pack(pack: "entertainer's pack")!
	static let Scholar 		= Pack(pack: "scholar's pack")!
}

let packDict = [
	"priest's pack": [
		"contents":  ["A blanket",
					  "10 candles", "a tinderbox",
					  "an alms box",
					  "2 blocks of incense",
					  "a censer",
					  "vestments",
					  "2 days of rations",
					  "a waterskin",							],],
	"explorer's pack": [
		"contents": ["A bedroll",
					 "a mess kit",
					 "a tinderbox",
					 "10 torches",
					 "10 days of rations",
					 "a waterskin",
					 "50 feet of hempen rope",					],],
	"dungeoneer's pack": [
		"contents":  ["a crowbar",
					  "a hammer",
					  "10 pitons",
					  "10 torches",
					  "a tinderbox",
					  "10 days of rations",
					  "a waterskin",
					  "50 feet of hempen rope",					],],
	"diplomat's pack": [
		"contents":  ["a chest",
					  "2 cases for maps and scrolls",
					  "a set of fine clothes",
					  "a bottle of ink",
					  "an ink pen",
					  "a lamp",
					  "2 flasks of oil",
					  "5 sheets of paper",
					  "a vial of perfume",
					  "sealing wax",
					  "a bar of soap",							],],
	"burglar's pack": [
		"contents":  ["A bag of 1000 ball bearings",
					  "10 feet of string",
					  "a bell",
					  "5 candles",
					  "a crowbar",
					  "a hammer",
					  "10 pitons",
					  "a hooded lantern",
					  "2 flasks of oil",
					  "5 days rations",
					  "a tinderbox",
					  "a waterskin",
					  "50 feet of hempen rope",					],],
	"entertainer's pack": [
		"contents": [ "A bedroll",
					  "2 costumes",
					  "5 candles",
					  "5 days of rations",
					  "a waterskin",
					  "a disguise kit.",						],],
	"scholar's pack": [
		"contents":  ["a book of lore",
						"a bottle of ink",
						"an ink pen",
						"10 sheets of parchment",
						"a little bag of sand",
						"a small knife.",						],],
]
