//
//  Spell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation


struct Spell {
	let level: String

	let name: String
	let description: String
	let school: String

	let range: String
	let castTime: String
	let duration: String
	let damage: String?


	let components: String

	func damageForCantrip() -> String {
		guard let damage = damage else { print("no damage value"); return ""}

		let level 		= Character.current.level

		if self.level != "0" { print("Invalid Spell level: \(level) \(name)"); return damage}


		if 		level >= 5  && level <= 10 	{ return "2\(damage)" }
		else if level >= 11 && level <= 16 	{ return "3\(damage)" }
		else if level >= 17 				{ return "4\(damage)" }
		else 								{return "1\(damage)" }
	}
}
