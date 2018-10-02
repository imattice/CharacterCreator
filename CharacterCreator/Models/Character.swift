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
	var race: Race!
	var `class`: Class! 		{ didSet { setGlobalTint() }}
	var stats: StatBlock		= StatBlock()
	var background: Background? = nil
	var items: [Item]			= [Item]()

	var proficiencies: [String] = [String]()
	lazy var proficiencyBonus: Int =  { calculateProficiencyBonus() }()

	//TODO: Spells should probably be moved to the Class
	var spellBook: [Spell]		= [Spell]()

	var flavorText: FlavorText  = FlavorText()
	var languages: [String] = [String]()


	private func calculateProficiencyBonus() -> Int {
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
	private func setGlobalTint() {
		guard let delegate = UIApplication.shared.delegate,
			let delegateWindow = delegate.window,
			let window = delegateWindow else { return }
		UIView.animate(withDuration: 2) {
			window.tintColor = Character.current.class.color().base()
		}
	}

	public init() {}

	//static information
	static var levelMax: Int { get { return 20 } }

	//the singleton 👻
	static let current = Character()
	static let `default` = Character(default: "default")

	private init(default: String) {
		self.class 			= Class(fromString: "wizard", withPath: "school of evocation")!
		self.race 			= Race(fromParent: "elf", withSubrace: "high")!
		self.stats 			= StatBlock(   str: StatBlock.Stat(value: 8),
										   con: StatBlock.Stat(value: 13),
										   dex: StatBlock.Stat(value: 10),
										   cha: StatBlock.Stat(value: 12),
										   wis: StatBlock.Stat(value: 14),
										   int: StatBlock.Stat(value: 15))
		self.background 	= Background("sage")
		self.items			= [Item("quarterstaff"),
								 Item("component pouch"),
								 Item("arcane focus"),
								 Item("scholar's pack"),
								 Item("spellbook"),
								 Item("a bottle of black ink"), Item("a quill"), Item("a small knife"), Item("a inquisitive letter")]
		self.proficiencies	= ["arcana", "history"]
		self.spellBook		= [Spell("Dancing Lights")!, Spell("Fire Bolt")!, Spell("Prestidigitation")!,
								 Spell("Charm Person")!, Spell("Identify")!, Spell("Sleep")!, Spell("Magic Missile")!, Spell("Thunderwave")!, Spell("Burning Hands")!]
		self.languages		= ["Common", "Elvan"]
	}

	init(race: Race, class: Class) {
		self.race 	= race
		self.class 	= `class`


	}

	func numberOfCantripsKnown() -> Int {
		return 3
	}
	func totalSpellsKnown() -> Int {
		guard let castingAttributes = self.class.castingAttributes else { return 0 }

		let abilityModifier = stats.stat(from: castingAttributes.castingAbility).modifier()
		var result = abilityModifier + level

		if result < 1 { result = 1 }

		return result
	}
	func numberOfAvailableSpellSlots() -> (spellLevel: Int, slots: Int) {
		return (spellLevel: 1, slots: 2)
	}
	func numberOfSpells(forSpellLevel level: Int) -> Int {
		let result = spellBook.filter({ $0.level == String(level) })
		return result.count
	}


}


//Structs
extension Character {
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

	struct FlavorText {
		var name: String			= "Unknown"
		var age: String				= "Uknown"
		var alignment: String		= "Neutral"
		var personality: String		= "Friendly"
		var gender: String			= "Unkown"
		var clothing: String		= "Common garb"
		var appearance: String		= "Unremarkable"
		var ideals: String			= "What keeps you going is a mystery."
		var bonds: String			= "You are interested in seeing new places and meeting new people."
		var flaws: String			= "You aren't one to admit your own faults."
		var relationships: String	= "You're known to keep your friends close and your enemies closer."
		var backstory: String		= "You find it hard to remember your past."

		var image: UIImage?			= UIImage(named: "elf")
	}
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

