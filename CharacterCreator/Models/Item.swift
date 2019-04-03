//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit

struct Item {
	let name: String
	let tags: [ItemTag]?

	init(_ name: String) {
		self.name = name

		if let itemDict = itemData[name] as? [String : Any] {
			if let tags = itemDict["tags"] as? [String] {
				var result = [ItemTag]()
				for tag in tags {
					guard let itemTag = ItemTag(rawValue: tag) else { print("could not create itemtag enum from \(tag)"); continue }
					result.append(itemTag)
				}
				self.tags = result
			}
			else {
				self.tags = nil
			}

		}
		else {
			self.tags = nil
		}
	}

	func description() -> String {
		guard let itemDict = itemData[name] as? [String : Any],
			var description = itemDict["description"] as? String
		else { print("could not create itemDict for \(name) for item description"); return "" }

		if let tags = tags,
			tags.contains(.special),
			let specialText = itemDict["special"] as? String {
			description += "\n\n*\(specialText)"
		}

		return description
	}

	func image() -> UIImage? {
		//if there's an icon for the specific name
		if let namedImage = UIImage(named: name) {
			return namedImage									}

		//if there's a icon for the tag
		if let tags = self.tags,
			let tag = tags.first {
			return tag.image()									}

		else {
			print("no image available for \(name)")
			return nil											}
	}

	func damage() -> Damage? {
		guard let itemDict 			= itemData[name] as? [String : Any],
			let damageDict 			= itemDict["damage"] as? [String : Any]
			else { print("damage data unavailable for \(name)"); return nil }

		return Damage(fromDict: damageDict)
	}

	enum ItemTag: String {
		case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special

		func image() -> UIImage? {
			switch self {
			case .ammunition: 	return UIImage(named: "bow")
			case .finesse: 		return UIImage(named: "rapier")
			case .heavy:		return UIImage(named: "warhammer")
			case .light: 		return UIImage(named: "dagger")
			case .loading: 		return UIImage(named: "crossbow")
			case .thrown: 		return UIImage(named: "handaxe")
			case .twoHanded: 	return UIImage(named: "bow")
			case .versatile: 	return UIImage(named: "staff")
			case .ranged: 		return UIImage(named: "bow")
			case .reach: 		return UIImage(named: "rapier")
			case .special: 		return UIImage(named: "arcane focus")
			}
		}
	}
}
