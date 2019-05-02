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

	override init(_ name: String) {
		super.init(name)

		if let itemDict 			= itemData[name] as? [String : Any],
			let damageDict 			= itemDict["damage"] as? [String : Any],
			let damage = Damage(fromDict: damageDict) {

			self.damage = damage
		}
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
