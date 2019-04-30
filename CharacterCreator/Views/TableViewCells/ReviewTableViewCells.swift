//
//  ReviewTableViewCells.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
	func tapped(_ isOpen: Bool) {

	}
}

class IdentityReviewTableViewCell: UITableViewCell {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var alignmentLabel: UILabel!

	func config() {
		nameLabel.text 			= Character.default.flavorText.name
		ageLabel.text			= "\(Character.default.flavorText.age) years old"
		alignmentLabel.text 	= Character.default.flavorText.alignment
	}
}
class RaceReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet weak var raceImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!

	func config() {
		raceImageView.image = UIImage(named: Character.default.race.parentRace)
		nameLabel.text		= Character.default.race.name()
		detailLabel.text	= Character.default.race.description()
	}

	override func tapped(_ isOpen: Bool) {
		print("is Open: \(isOpen)")
		if !isOpen {
			detailLabel.numberOfLines = 0		}
		else {
			detailLabel.numberOfLines = 2		}
	}
}
class ClassReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet weak var classImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!

	func config() {
		classImageView.image	= UIImage(named: Character.default.class.base)
		nameLabel.text			= Character.default.class.name()
		detailLabel.text		= "\(Character.default.class.baseDescription())\n\n\(Character.default.class.pathDescription())"
	}

	override func tapped(_ isOpen: Bool) {
		print("is Open: \(isOpen)")
		if !isOpen {
			detailLabel.numberOfLines = 0		}
		else {
			detailLabel.numberOfLines = 2		}
	}
}

class BackgroundReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var backgroundImageView: UIImageView!

	func config() {
		titleLabel.text = "\(Character.default.background!.name.capitalized) Background"
		detailLabel.text = Character.default.background?.description()
		backgroundImageView.image = UIImage(named: Character.default.background!.name)
	}
	override func tapped(_ isOpen: Bool) {
		print("is Open: \(isOpen)")
		if isOpen == false {
			detailLabel.numberOfLines = 0		}
		else {
			detailLabel.numberOfLines = 2		}
	}
}

class StatReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet var statStacks: [StatStack]!
	@IBOutlet weak var modifierLabelStack: UIStackView!

	func config() {
		for statStack in statStacks {
			statStack.config()
		}
//		modifierLabelStack.isHidden	= true
	}

	override func tapped(_ isOpen: Bool) {
			for statStack in statStacks {
				statStack.distribution				= isOpen ? .equalSpacing 	: .fillProportionally

				statStack.statLabel.isHidden		= isOpen ? true				: false

				statStack.rawLabel.isHidden			= isOpen ? false 			: true
				statStack.racialBonusLabel.isHidden	= isOpen ? false 			: true
				statStack.otherBonusLabel.isHidden	= isOpen ? false 			: true
				statStack.totalLabel.isHidden		= isOpen ? false 			: true
			}

			modifierLabelStack.isHidden				= isOpen ? false			: true
	}
}

class StatStack: UIStackView {
	@IBOutlet weak var modifierLabel: UILabel!
	@IBOutlet weak var statLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var rawLabel: UILabel!
	@IBOutlet weak var racialBonusLabel: UILabel!
	@IBOutlet weak var otherBonusLabel: UILabel!
	@IBOutlet weak var totalLabel: UILabel!

	func config() {
		guard let text = titleLabel.text,
			let statName = StatType(rawValue: text.lowercased()),
			let stat = Character.default.stat(forName: statName)	else { print("didn't work"); return }


		modifierLabel.text	= stat.modifier > 0 ? "+\(stat.modifier)" : String(stat.modifier)
		statLabel.text		= String(stat.modifiedValue)

		//expanded labels
		rawLabel.text 		= String(stat.rawValue)
		if let modifier = Character.default.race.modifiers.filter({ $0.type == .increaseStat && $0.attribute == text.lowercased() }).first {
			racialBonusLabel.text	= "+\(modifier.value)"		}
		else {
			racialBonusLabel.text	= "-"						}
		otherBonusLabel.text		= "-"
		totalLabel.text			= String(stat.modifiedValue)



	}
}

class SpellReviewTableViewCell: UITableViewCell {
	@IBOutlet weak var cantripSpellListLabel: UILabel!
	@IBOutlet weak var firstLevelSpellListLabel: UILabel!

	func config() {
		cantripSpellListLabel.text 		= spellList(forSpellLevel: 0)
		firstLevelSpellListLabel.text 	= spellList(forSpellLevel: 1)
	}

	private func spellList(forSpellLevel level: Int) -> String {
		guard Character.default.class.castingAttributes != nil
			else { return "\(Character.current.class.name())'s are not able to cast spells."}
		guard Character.current.spellBook.isEmpty else { return "\(Character.current.flavorText.name) does not know any spells." }

		var result = ""
		let spells = Character.current.spellBook.filter({ $0.level == level })

		for spell in spells {
			result += "\(spell.name)  |  "
		}

		return String(Substring(result).dropLast(5))
	}
}



class SkillReviewTableViewCell: UITableViewCell {
	@IBOutlet weak var athleticsLabel: UILabel!
	@IBOutlet weak var acrobaticsLabel: UILabel!
	@IBOutlet weak var slightOfHandLabel: UILabel!
	@IBOutlet weak var stealthLabel: UILabel!
	@IBOutlet weak var deceptionLabel: UILabel!
	@IBOutlet weak var intimidationLabel: UILabel!
	@IBOutlet weak var performanceLabel: UILabel!
	@IBOutlet weak var persuasionLabel: UILabel!
	@IBOutlet weak var arcanaLabel: UILabel!
	@IBOutlet weak var historyLabel: UILabel!
	@IBOutlet weak var investigationLabel: UILabel!
	@IBOutlet weak var natureLabel: UILabel!
	@IBOutlet weak var religionLabel: UILabel!
	@IBOutlet weak var animalHandlingLabel: UILabel!
	@IBOutlet weak var insightLabel: UILabel!
	@IBOutlet weak var medicineLabel: UILabel!
	@IBOutlet weak var perceptionLabel: UILabel!
	@IBOutlet weak var survivalLabel: UILabel!

	func config() {
		for skillString in skills {
			let skill = Skill(fromString: skillString)!
			let modifier = Character.default.skillModifier(for: skill)
			var text = ""

			if modifier >= 0 { text = "+ \(modifier)" } else if modifier < 0 { text = "- \(abs(modifier))" }
			text = ": \(text)"

			label(forSkill: skillString).text = text
		}

	}

	private func label(forSkill skill: String) -> UILabel {
		switch skill {
		case "athletics" : 		return athleticsLabel

		case "acrobatics" : 	return acrobaticsLabel
		case "slight of hand" : return slightOfHandLabel
		case "stealth" : 		return stealthLabel

		case "deception" : 		return deceptionLabel
		case "intimidation" : 	return intimidationLabel
		case "performance" : 	return performanceLabel
		case "persuasion" : 	return persuasionLabel

		case "arcana" : 		return arcanaLabel
		case "history" : 		return historyLabel
		case "investigation" : 	return investigationLabel
		case "nature" : 		return natureLabel
		case "religion" : 		return religionLabel

		case "animal handling" : return animalHandlingLabel
		case "insight" : 		return insightLabel
		case "medicine" : 		return medicineLabel
		case "perception" : 	return perceptionLabel
		case "survival" : 		return survivalLabel

		default: 				return UILabel()
		}
	}
}

class InventoryReviewTableViewCell: UITableViewCell {
	@IBOutlet weak var leftColumnLabel: UILabel!
	@IBOutlet weak var rightColumnLabel: UILabel!

	func config() {
		let items = Character.default.items
		var rightText 	= ""
		var leftText 	= ""

		for index in 0...items.count-1 {
			if index <= items.count/2 {
				leftText += "• \(items[index].name.capitalized)\n"  }
			else {
				rightText += "• \(items[index].name.capitalized)\n" }
		}

		leftColumnLabel.text 	= leftText
		rightColumnLabel.text 	= rightText
	}
}

//protocol Configurable {
//	func config()
//}

//class IdentityTableViewCell: UITableViewCell {
//
//}


