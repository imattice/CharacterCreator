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
	let type: ItemType

	init(_ name: String) {
		if let itemDict = itemData[name] as? [String : Any],
			let typeKey = itemDict["type"] as? String,
			let type = ItemType(rawValue: typeKey){

			self.type = type	}
		else { self.type = .other }

		self.name = name
	}

	func description() -> String {
		guard let itemDict = itemData[name] as? [String : Any],
			let description = itemDict["description"] as? String
		else { print("could not create itemDict for \(name)"); return "" }

		return description
	}

	func image() -> UIImage? {
		//if there's an icon for the specific name
		if let namedImage = UIImage(named: name) {
			return namedImage									}

		//if there's a icon for the type
		if let typeImage = UIImage(named: type.rawValue) {
			return typeImage									}

		//fall back on some default images
		else {
			switch type {
			case .meleeWeapon,
				 .simple: 		return UIImage(named: "sword")
			case .rangedWeapon: return UIImage(named: "bow")
			case .mixedWeapon: 	return UIImage(named: "handaxe")
			default:			return UIImage(named: "arcane focus")
			}

		}
	}
}
