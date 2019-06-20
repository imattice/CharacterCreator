//
//  ReviewTableViewCells.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
	override func awakeFromNib() {
		super.awakeFromNib()
		config()
	}
	func config() {	}
	func tapped(_ isOpen: Bool) {	}
}

class IdentityReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var alignmentLabel: UILabel!

	override func config() {
		nameLabel.text 			= Character.default.flavorText.name
		ageLabel.text			= "\(Character.default.flavorText.age) years old"
		alignmentLabel.text 	= Character.default.flavorText.alignment
	}
}
class RaceReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet weak var raceImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!

	override func config() {
		raceImageView.image = UIImage(named: Character.default.race.parentRace)
		nameLabel.text		= Character.default.race.name()
		detailLabel.text	= Character.default.race.description()

		super.config()
	}

	override func tapped(_ isOpen: Bool) {
//		print("is Open: \(isOpen)")
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

	override func config() {
		classImageView.image	= UIImage(named: Character.default.class.base)
		nameLabel.text			= Character.default.class.name()
		detailLabel.text		= "\(Character.default.class.baseDescription())\n\n\(Character.default.class.pathDescription())"

		super.config()
	}

	override func tapped(_ isOpen: Bool) {
//		print("is Open: \(isOpen)")
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

	override func config() {
		titleLabel.text = "\(Character.default.background!.name.capitalized) Background"
		detailLabel.text = Character.default.background?.description()
		backgroundImageView.image = UIImage(named: Character.default.background!.name)

		super.config()
	}
	override func tapped(_ isOpen: Bool) {
//		print("is Open: \(isOpen)")
		if !isOpen {
			detailLabel.numberOfLines = 0		}
		else {
			detailLabel.numberOfLines = 2		}
	}
}

class StatReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet var statStacks: [StatStack]!
	@IBOutlet weak var modifierLabelStack: UIStackView!

	override func config() {
		for statStack in statStacks {
			statStack.config()
		}
		super.config()
	}

	override func tapped(_ isOpen: Bool) {
		let isOpen = !isOpen
			for statStack in statStacks {
				statStack.distribution				= isOpen ? .fillProportionally		: .equalSpacing

				statStack.statLabel.isHidden		= isOpen ? false					: true

				statStack.rawLabel.isHidden			= isOpen ? true						: false
				statStack.racialBonusLabel.isHidden	= isOpen ? true						: false
				statStack.otherBonusLabel.isHidden	= isOpen ? true						: false
				statStack.totalLabel.isHidden		= isOpen ? true						: false
			}

		modifierLabelStack.isHidden					= isOpen ? true						: false
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

class SkillReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet var skillStacks: [SkillStack]!

	override func config() {
		for skillStack in skillStacks {
			guard let text = skillStack.titleLabel.text,
				let skill = Skill(fromString: text.lowercased()) else { continue }
			let modifier = Character.default.skillModifier(for: skill)

			skillStack.modifierBonusLabel.text	= modifier >= 0 ? ": +\(modifier)" : ": -\(abs(modifier))"

			skillStack.titleLabel.adjustsFontSizeToFitWidth = true
		}
	}
}

class SkillStack: UIStackView {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var modifierBonusLabel: UILabel!
}

class InventoryReviewTableViewCell: ReviewTableViewCell {
	@IBOutlet weak var weaponStack: UIStackView!
	@IBOutlet weak var itemLabel: UILabel!
	@IBOutlet weak var acValueLabel: UILabel!
	@IBOutlet weak var armorLabel: UILabel!

	override func config() {
		fillStackView()
		addArmorLabels()
		addItemText()

		setNeedsLayout()
		layoutIfNeeded()
	}

	func fillStackView() {
		addWeapons()
	}

	private func addWeapons() {
		//remove the placeholder view from the storyboard
		if let placeholder = weaponStack.viewWithTag(100) {
			placeholder.removeFromSuperview()
		}

		//get an array of items that are weapons and no duplicates
		let weapons = Character.default.items.filter({ $0.type == .weapon }).duplicatesRemoved()

		for weapon in weapons {
			let weaponView = WeaponStatView()
			weaponView.weapon = weapon as? Weapon

			weaponView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint(item: weaponView,
							   attribute: .height,
							   relatedBy: .equal,
							   toItem: nil, attribute: .notAnAttribute,
							   multiplier: 1,
							   constant: 60).isActive = true

			weaponStack.addArrangedSubview(weaponView)
		}
	}

	private func addArmorLabels() {
		var armorText = ""		
		if let armor = Character.default.items.filter({ $0.type == .armor }).first {
			armorText	= armor.name.capitalized									}

		if Character.default.items.contains(where: { $0.type == .shield }) {
			armorText	+= "\n+ Shield"										}

		acValueLabel.text	= String(Character.default.armorClass())
		armorLabel.text		= armorText
	}

	private func addItemText() {
		let items = Character.default.items.filter({ $0.type == .custom || $0.type == .other })
		var itemText 	= ""

		for item in items {
		itemText += "• \(item.name.capitalized)\n"  }

		if let pack = Character.default.items.filter( { $0.type == .pack }).first as? Pack {
			itemText += "• A \(pack.name.capitalized)\n containing:"

			for item in pack.contents {
				itemText += "\n     • \(item)"
			}
		}

		itemLabel.text 	= itemText
	}
}

class SpellReviewTableViewCell: ReviewTableViewCell{
	@IBOutlet weak var cantripSpellListLabel: UILabel!
	@IBOutlet weak var firstLevelSpellListLabel: UILabel!

	override func config() {
		cantripSpellListLabel.text 		= spellList(forSpellLevel: 0)
		firstLevelSpellListLabel.text 	= spellList(forSpellLevel: 1)
	}

	private func spellList(forSpellLevel level: Int) -> String {
		guard Character.default.class.castingAttributes != nil
			else { return "\(Character.default.class.name())'s are not able to cast spells."}
		guard Character.current.spellBook.isEmpty else { return "\(Character.current.flavorText.name) does not know any spells." }

		var result = ""
		let spells = Character.default.spellBook.filter({ $0.level == level })

		for spell in spells {
			result += "\(spell.name)  |  "
		}

		return String(Substring(result).dropLast(5))
	}
}


