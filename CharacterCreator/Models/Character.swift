//
//  Character.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit

class Character {
	//character creation values
	var level: Int				= 1
	var `class`: Class? 		= nil { didSet {
		UIView.animate(withDuration: 2) {
			UIApplication.shared.delegate!.window!!.tintColor = UIColor.colorForCurrentClass()
//			print("Character.swift: global tint is set")
		}}}
	var race: Race?				= nil
	var stats: StatBlock		= StatBlock()
	var background: Background? = nil
	var items: [Item]			= [Item]()

	lazy var proficiencyBonus: Int =  { calculateProficiencyBonus() }()
	var proficiencies: [String] = [String]()

	var spellBook: [Spell]		= [Spell]()

	init(class: Class, race: Race, stats: StatBlock, background: Background) {
		self.class 		= `class`
		self.race 		= race
		self.stats  	= stats
		self.background = background

		proficiencyBonus	= calculateProficiencyBonus()
	}

	struct StatBlock {
		var str: Stat		= Stat(value: 0)
		var con: Stat		= Stat(value: 0)
		var dex: Stat		= Stat(value: 0)
		var cha: Stat		= Stat(value: 0)
		var wis: Stat		= Stat(value: 0)
		var int: Stat		= Stat(value: 0)

		func stat(from stat: StatType) -> Stat{
			switch stat {
			case .str: 		return self.str
			case .con:		return self.con
			case .dex:		return self.dex
			case .cha:		return self.cha
			case .int:		return self.int
			case .wis:		return self.wis
			}
		}

		struct Stat {
			let value: Int

			func modifier() -> Int {
				return value / 2 - 5
			}
		}
	}



	func numberOfSpellsKnown() -> Int? {
		if let currentClass = self.class,
			let castingAbility = currentClass.castingAbility {

			let castingModifier = self.stats.stat(from: castingAbility).modifier()

			return castingModifier + level
		} else {
			print("failed to initialize stat from the class \(String(describing: self.class))")

			return level
		}
	}
	private func calculateProficiencyBonus() -> Int {
		//level 1 - 4:   2
		//level 5 - 8:   3
		//level 9 - 12:  4
		//level 13 - 16: 5
		//level 17 - 20: 6
		let	result = Int((Double(level) / 4.0).rounded(.up)) + 1


		return result
	}

	func skillModifier(for skill: Skill) -> Int {
		var result = stats.stat(from: skill.stat()).modifier()

		//if proficient, add the modifier
		if proficiencies.contains(skill.rawValue) {
			result += proficiencyBonus
		}

		return result
	}

	public init() { }

	//static information
	static var levelMax: Int { get { return 20 } }

	//the singleton 👻
	static let current = Character()
	static let `default` = Character(class: Class(fromString: "wizard", withPath: "school of evocation")!,
									 race: Race(fromParent: "elf", withSubrace: "high")!,
									 stats: StatBlock(str: StatBlock.Stat(value: 8),
													  con: StatBlock.Stat(value: 13),
													  dex: StatBlock.Stat(value: 10),
													  cha: StatBlock.Stat(value: 12),
													  wis: StatBlock.Stat(value: 14),
													  int: StatBlock.Stat(value: 15)),
									 background: Background(name: "sage"))
}

enum StatType: String {
	case str,
	con,
	dex,
	cha,
	wis,
	int

	init?(fromLonghand string: String){
		switch string.lowercased() {
		case "strength":		self.init(rawValue: "str")
		case "constitution":	self.init(rawValue: "con")
		case "dexterity":		self.init(rawValue: "dex")
		case "charisma":		self.init(rawValue: "cha")
		case "wisdom":			self.init(rawValue: "wis")
		case "intelligence":	self.init(rawValue: "int")

		default: print("could not create StatType from \(string)"); return nil
		}
	}

	func label() -> String {
		switch self {
		case .str:		return "Strength"
		case .con:		return "Constitution"
		case .dex:		return "Dexterity"
		case .cha:		return "Charisma"
		case .wis:		return "Wisdom"
		case .int:		return "Intelligence"
		}
	}

}

