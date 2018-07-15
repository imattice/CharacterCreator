//
//  UIColor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/12/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

protocol Paintable {
	func paint()
}

extension UIColor {

	private struct ClassColor {
		static let cleric 		= UIColor.yellow
		static let fighter		= UIColor.red
		static let wizard		= UIColor.purple
		static let rogue		= UIColor.darkGray
	}

	static func paintColor() -> UIColor {
		var targetClass: String 	= "wizard"
		if let characterClass 		= Character.current.class { targetClass = characterClass.base.lowercased() }

		switch targetClass {
		case "fighter": 	return UIColor.ClassColor.fighter
		case "cleric": 		return UIColor.ClassColor.cleric
		case "rogue":		return UIColor.ClassColor.rogue
		case "wizard":		return UIColor.ClassColor.wizard

		default:			print("false color"); return UIColor.ClassColor.rogue
		}

	}

//	struct RaceColor {
//		static let human 		= UIColor.white
//		static let elf 			= UIColor.lightGreen
//		static let dwarf 		= UIColor.brown
//		static let halfling 	= UIColor.burntOrange
//	}
}
