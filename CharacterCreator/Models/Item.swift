//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit

class Item {
	let name: String
//	let tags: [ItemTag]?
	let type: ItemType
//	let isMagical: Bool

	init(_ name: String) {
		self.name = name.lowercased()

		if let itemDict = itemData[name.lowercased()] as? [String : Any],
			let type = itemDict["type"] as? String,
			let itemType = ItemType(rawValue: type)
		{

			self.type	= itemType					}
		else {
			self.type	= .custom					}
	}

	func description() -> String {
		guard let itemDict = itemData[name.lowercased()] as? [String : Any],
			let description = itemDict["description"] as? String
		else { print("could not create itemDict for \(name) for item description"); return "" }

//		if let tags = tags,
//			tags.contains(.special),
//			let specialText = itemDict["special"] as? String {
//			description += "\n\n*\(specialText)"
//		}

		return description
	}

	func image() -> UIImage? {
		//if there's an icon for the specific name
		if let namedImage = UIImage(named: name) {
			return namedImage									}

		else {
			return nil											}

//		//if there's a icon for the tag
//		if let tags = self.tags,
//			let tag = tags.first {
//			return tag.image()									}
//
//		else {
//			print("no image available for \(name)")
//			return nil											}
	}

//	func damage() -> Damage? {
//		guard let itemDict 			= itemData[name] as? [String : Any],
//			let damageDict 			= itemDict["damage"] as? [String : Any]
//			else { print("damage data unavailable for \(name)"); return nil }
//
//		return Damage(fromDict: damageDict)
//	}


	enum ItemType: String {
		case weapon, armor, shield, pack, other, custom
	}

}
