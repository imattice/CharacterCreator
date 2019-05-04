//
//  Character.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit

class Character {
	var level: Int				= 1
	var race: Race!
	var `class`: Class! 		{ didSet { setGlobalTint() }}
	var stats: [Stat]		= [Stat]() //StatBlock()
	var background: Background? = nil
	var items: [Item]			= [Item]()

	var proficiencies: [String] = [String]()
	lazy var proficiencyBonus: Int =  { calculateProficiencyBonus() }()

	var spellBook: [Spell]		= [Spell]()

	var flavorText: FlavorText  = FlavorText()
//	var languages: [String] = [String]()
	var languages = ( innate: [LanguageRecord](), selected: [LanguageRecord]())


	func proficiencyChoiceCount() -> Int {
		return self.class.base == "rogue" ? 4 : 2	}

	private func calculateProficiencyBonus() -> Int {
		let	result = Int((Double(level) / 4.0).rounded(.up)) + 1
		return result
	}

	func skillModifier(for skill: Skill) -> Int {
		guard let stat = stat(forName: skill.stat()) else { return 0 }
		var result = stat.modifier

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
		self.class 			= Class.EvocationWizard
		self.race 			= Race.ElfHigh
		self.stats 			= [Stat(name: .str, rawValue: 8),
								  Stat(name: .con, rawValue: 13),
								  Stat(name: .dex, rawValue: 10),
								  Stat(name: .cha, rawValue: 12),
								  Stat(name: .wis, rawValue: 14),
								  Stat(name: .int, rawValue: 15)]
		self.background 	= Background.Sage
		self.items			= [ Weapon.Quarterstaff,
								  Weapon.Dagger,
								  Weapon.Dagger,
								  Armor.ScaleMail,
								  Armor.Shield,
								  Item.ComponentPouch,
								  Item.ArcaneFocus,
								 Pack.Scholar,
								 Item("spellbook"),
								 Item("a bottle of black ink"), Item("a quill"), Item("a small knife"), Item("a inquisitive letter")]
		self.proficiencies	= ["arcana", "history"]
		self.spellBook		= [Spell("Dancing Lights")!, Spell("Fire Bolt")!, Spell("Prestidigitation")!,
								 Spell("Charm Person")!, Spell("Identify")!, Spell("Sleep")!, Spell("Magic Missile")!, Spell("Thunderwave")!, Spell("Burning Hands")!]
		self.languages		= (innate: (Race(fromParent: "elf", withSubrace: "high")!.languages() + Background("sage").languages()),
								 selected: [LanguageRecord]())
		self.flavorText		= FlavorText(name: "Alpheon the Chronicler",
											age: "138",
											alignment: "Lawful Good",
											personality: "Alpheon is a nervous librarian from Mount Celestia, tasked with the job of following adventuerers and recording their heroic deeds for the history books.",
											gender: "male",
											clothing: "",
											appearance: "Wearing scholar's robes and carrying a load of books and quills, Alpheon often looks a bit scattered as important pages often find their way to the floor around him",
											ideals: "Knowledge: The path to power and self-improvement is through knowledge.",
											bonds: "I work to preserve a library, university, scriptorium, or monastery.",
											flaws: "Unlocking an ancient mystery is worth the price of a civilization.",
											relationships: "Alpheon is believes in his work whole-heartedly and is very attached to the library he works at",
											backstory: "Alpheon has studied for years at the Celestia library and is finally tasked with his first duty: locate a party that is due for an adventure and record their achievements and failures",
											image: UIImage(named: "elf"))
	}

	init(race: Race, class: Class) {
		self.race 	= race
		self.class 	= `class`
	}

	func numberOfCantripsKnown() -> Int {
		return 3
	}
	func totalSpellsKnown() -> Int {
		guard let castingAttributes = self.class.castingAttributes,
			let stat = stat(forName: castingAttributes.castingAbility) else { return 0 }

		let abilityModifier = stat.modifier
		var result = abilityModifier + level

		if result < 1 { result = 1 }

		return result
	}
	func numberOfAvailableSpellSlots() -> (spellLevel: Int, slots: Int) {
		return (spellLevel: 1, slots: 2)
	}
	func spellSlots(forSpellLevel level: Int) -> Int {
		return 2
	}
	func numberOfSpells(forSpellLevel level: Int) -> Int {
		let result = spellBook.filter({ $0.level == level })
		return result.count
	}
	func stat(forName name: StatType) -> Stat? {
		return self.stats.first(where: {$0.name == name })
	}
	func armorClass() -> Int {
		var armorBonus 	= 0
		var dexMod		= 0
		var shieldBonus	= 0

		if let armor = items.filter({ $0.type == .armor }).first as? Armor {
			armorBonus = armor.acBonus
		}

		if let dex = stats.filter({ $0.name == .dex }).first {
			dexMod = dex.modifier								}

		if let shield = items.filter({ $0.type == .shield }).first as? Armor {
			shieldBonus	= shield.acBonus
		}

		return 10 + armorBonus + dexMod + shieldBonus
	}
//	func modifiedStat(forStat stat: StatType) -> Stat? {
//		guard let baseStat = self.stat(forName: stat),
//			let race = race else { return nil }
//		var resultValue = baseStat.rawValue
//
//		//look for modifiers that increase stats and are also for this particular stat
//		let modifiers = race.modifiers.filter( { $0.type == .increaseStat && $0.attribute == baseStat.name.rawValue })
//		if !modifiers.isEmpty {
//			for modifier in modifiers {
//				resultValue += modifier.value
//			}
//		}
//		return Stat(name: stat, rawValue: resultValue)
//	}
}


//Structs
extension Character {
//	struct StatBlock {
//		var str: Stat		= Stat(name: "str", value: 0)
//		var con: Stat		= Stat(name: "con", value: 0)
//		var dex: Stat		= Stat(name: "dex", value: 0)
//		var cha: Stat		= Stat(name: "cha", value: 0)
//		var wis: Stat		= Stat(name: "wis", value: 0)
//		var int: Stat		= Stat(name: "int", value: 0)
//
//		func stat(from stat: StatType) -> Stat{
//			switch stat {
//			case .str: 		return self.str
//			case .con:		return self.con
//			case .dex:		return self.dex
//			case .cha:		return self.cha
//			case .int:		return self.int
//			case .wis:		return self.wis
//			}
//		}
//
//		struct Stat {
//			let name: String
//			let value: Int
//
//			func modifier() -> Int {
//				return value / 2 - 5
//			}
//		}
//	}

	struct Stat {
		let name: StatType
		let rawValue: Int
		var modifiedValue: Int {
			guard let race = Character.default.race else { return rawValue }
			var resultValue = rawValue

			//look for modifiers that increase stats and are also for this particular stat
			let modifiers = race.modifiers.filter( { $0.type == .increaseStat && $0.attribute == name.rawValue })
			if !modifiers.isEmpty {
				for modifier in modifiers {
					resultValue += modifier.value
				}
			}
			return resultValue
		}
		var modifier: Int {
			return modifiedValue / 2 - 5 }
//		func modifier() -> Int {
//			return modifiedValue / 2 - 5
//		}
	}

//		static let str = Character.default.stats.first(where: {$0.name == "str"})

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

