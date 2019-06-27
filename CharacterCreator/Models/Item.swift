//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit
import RealmSwift

@objcMembers
class ItemRecord: Object {
	dynamic var id: String			= UUID().uuidString
	dynamic var name: String		= ""
//	dynamic var detail: String		= ""

	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<ItemRecord> {
		return realm.objects(ItemRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> ItemRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

	func item() -> Item {
		return Item(name, type: .other)
	}
}



class Item {
	let name: String
	let type: ItemType

	init(_ name: String, type: ItemType) {
		self.name	= name
		self.type	= type
	}

	lazy var detail: String = {
		guard let itemDict = itemData[name.lowercased()] as? [String : Any],
			let description = itemDict["description"] as? String
		else { print("could not create itemDict for \(name) for item description"); return "" }

		return description
	}()

	func image() -> UIImage? {
		//if there's an icon for the specific name
		if let namedImage = UIImage(named: name) {
			return namedImage									}

		else {
			return nil											}
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
}
