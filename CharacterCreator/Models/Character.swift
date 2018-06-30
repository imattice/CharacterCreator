//
//  Character.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

class Character {
	var `class`: Class? 		= nil
	var race: Race?				= nil
	var stats: StatBlock		= StatBlock()

	struct StatBlock {
		var str: Int		= 0
		var con: Int		= 0
		var dex: Int		= 0
		var cha: Int		= 0
		var wis: Int		= 0
		var int: Int		= 0
	}

	static let current = Character()

	public init() { }
}
