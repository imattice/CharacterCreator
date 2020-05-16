//
//  Pack.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/3/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

//defines an item that contains an assortment of tools and small items that come grouped together
class Pack: Item {
	let contents: [String]

	init(name: String, contents: [String], detail: String) {
		self.contents	= contents

		super.init(name, type: .pack, detail: detail)
	}
}

extension Pack {
//	static let Priest 		= PackRecord.record(for: "priest's pack")!.pack()
//	static let Explorer 	= PackRecord.record(for: "explorer's pack")!.pack()
//	static let Dungeoneer 	= PackRecord.record(for: "dungeoneer's pack")!.pack()
//	static let Diplomat 	= PackRecord.record(for: "diplomat's pack")!.pack()
//	static let Burgler 		= PackRecord.record(for: "burglar's pack")!.pack()
//	static let Entertainer	= PackRecord.record(for: "entertainer's pack")!.pack()
//	static let Scholar 		= PackRecord.record(for: "scholar's pack")!.pack()
}


@objcMembers
class PackRecord: Object {
	dynamic var id: String				= UUID().uuidString
	dynamic var name: String			= ""
	dynamic let contents: List<String> 	= List<String>()
	dynamic var detail: String			= "A detailed description"

	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<PackRecord> {
		return realm.objects(PackRecord.self)//.sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> PackRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

	func pack() -> Pack {
		return Pack(name: name, contents: Array(contents), detail: detail)
	}
}

//let packDict = [
//	"priest's pack": [
//		"contents":  ["A blanket",
//					  "10 candles", "a tinderbox",
//					  "an alms box",
//					  "2 blocks of incense",
//					  "a censer",
//					  "vestments",
//					  "2 days of rations",
//					  "a waterskin",							],],
//	"explorer's pack": [
//		"contents": ["A bedroll",
//					 "a mess kit",
//					 "a tinderbox",
//					 "10 torches",
//					 "10 days of rations",
//					 "a waterskin",
//					 "50 feet of hempen rope",					],],
//	"dungeoneer's pack": [
//		"contents":  ["a crowbar",
//					  "a hammer",
//					  "10 pitons",
//					  "10 torches",
//					  "a tinderbox",
//					  "10 days of rations",
//					  "a waterskin",
//					  "50 feet of hempen rope",					],],
//	"diplomat's pack": [
//		"contents":  ["a chest",
//					  "2 cases for maps and scrolls",
//					  "a set of fine clothes",
//					  "a bottle of ink",
//					  "an ink pen",
//					  "a lamp",
//					  "2 flasks of oil",
//					  "5 sheets of paper",
//					  "a vial of perfume",
//					  "sealing wax",
//					  "a bar of soap",							],],
//	"burglar's pack": [
//		"contents":  ["A bag of 1000 ball bearings",
//					  "10 feet of string",
//					  "a bell",
//					  "5 candles",
//					  "a crowbar",
//					  "a hammer",
//					  "10 pitons",
//					  "a hooded lantern",
//					  "2 flasks of oil",
//					  "5 days rations",
//					  "a tinderbox",
//					  "a waterskin",
//					  "50 feet of hempen rope",					],],
//	"entertainer's pack": [
//		"contents": [ "A bedroll",
//					  "2 costumes",
//					  "5 candles",
//					  "5 days of rations",
//					  "a waterskin",
//					  "a disguise kit.",						],],
//	"scholar's pack": [
//		"contents":  ["a book of lore",
//						"a bottle of ink",
//						"an ink pen",
//						"10 sheets of parchment",
//						"a little bag of sand",
//						"a small knife.",						],],
//]
