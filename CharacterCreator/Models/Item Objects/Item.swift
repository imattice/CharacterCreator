//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit
import RealmSwift

class Item {
	let name: String
	let type: ItemType
	let detail: String

	lazy var image: UIImage? = {
		if let image = UIImage(named: name) { return image } else { return nil } }()

	init(_ name: String, type: ItemType = .other, detail: String = "") {
		self.name	= name
		self.type	= type
		self.detail	= detail
	}

	enum ItemType: String {
		case weapon, armor, shield, pack, other, custom
	}
}

extension Item: Equatable {
	static func == (lhs: Item, rhs: Item) -> Bool {
		return lhs.name == rhs.name
	}
}

extension Item {
	static let ComponentPouch 	= ItemRecord.record(for: "component pouch")!.item()
	static let ArcaneFocus		= ItemRecord.record(for: "arcane focus")!.item()
	static let Spellbook		= ItemRecord.record(for: "spellbook")!.item()
	static let HolySymbol		= ItemRecord.record(for: "holy symbol")!.item()
}



@objcMembers
class ItemRecord: Object {
	dynamic var id: String			= UUID().uuidString
	dynamic var name: String		= ""
	dynamic var detail: String		= ""

	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<ItemRecord> {
		return realm.objects(ItemRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> ItemRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

	func item() -> Item {
		return Item(name, type: .other, detail: detail)
	}
}
