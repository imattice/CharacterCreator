//
//  Damage.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation


struct Damage {
	let multiplier: Int
	let type: DamageType
	let value: Int


	func rollString(withType: Bool) -> String {
		var result = "\(multiplier)d\(value)"
		if withType { result += " \(type.rawValue)" }
		return result
	}
	enum DamageType: String {
		case acid, fire, cold, thunder, poison, necrotic, radient, force, bludgeoning, piercing, slashing
	}
}

