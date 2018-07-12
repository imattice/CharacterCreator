//
//  Character.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

class Character {
	//character creation values
	var level: Int				= 1
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


	public init() { }

	//static information
	static var levelMax: Int { get { return 20 } }

	//the singleton 👻
	static let current = Character()
}
