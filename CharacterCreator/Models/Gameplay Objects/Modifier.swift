//
//  Modifier.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//defines a method that changes a value or calculation for any object, such as stats, damage, or AC
struct Modifier: Codable {
	let type: ModifierType
	let attribute: String
	let value: Int
	let origin: ModifierOrigin

    enum ModifierOrigin: String, Codable {
        case race,
             subrace,
             `class`
    }
    enum ModifierType: String, Codable	{
		case onAdvantage,
		grantAdvantage,
		onDisadvantage,
		imposeDisadvantage,
		increaseStat,
		decreaseStat,
		increaseHP,
		decreaseHP
	}
}
