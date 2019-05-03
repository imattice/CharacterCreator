//
//  Weapon.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/1/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit


class Weapon: Item {
	let tags: [Tag]
	let damage: Damage
	let `class`: WeaponClass

	lazy var isRanged: Bool = {
		return tags.contains(.ranged) }()

	init?(weapon name: String) {
		guard let itemDict 			= itemData[name] as? [String : Any] else { return nil }

		if let classData = itemDict["class"] as? String,
			let weaponClass = WeaponClass(rawValue: classData) {
			self.class	= weaponClass
		} else { return nil }

		if let damageDict 			= itemDict["damage"] as? [String : Any],
			let damage = Damage(fromDict: damageDict) {

			self.damage = damage
		}
		else { self.damage	= Damage(multiplier: 0, type: .force, value: 0)	}

		var tags = [Tag]()
		if let tagData = itemDict["tags"] as? [String] {
			for tagRecord in tagData {
				guard let tag = Tag(rawValue: tagRecord) else { print("could not create itemtag enum from \(tagRecord)"); continue }
				tags.append(tag)
			}
		}
		self.tags = tags

		super.init(name)
	}


	enum Tag: String {
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

	enum WeaponClass: String {
		case martial, simple
	}
}

class WeaponSelectionItem: Item {
	let category: Category

	override init(_ name: String) {
		if name == "martial weapon" {
			self.category 	= .martial	}
		else {
			self.category	= .simple	}

		super.init(name)
	}


	enum Category {
		case simple, martial	}
}
