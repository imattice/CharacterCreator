//
//  SpellTableViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/6/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class SpellTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var iconView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var componentLabel: UILabel!

	var spell: Spell?
//	var expanded: Bool = false

//	func configure(for spell: Spell) {
//		titleLabel.text 			= spell.name
//		descriptionLabel.text		= spell.description()
//		iconView.image				= UIImage(named: spell.school)
//
//		componentLabel.text			= expanded ? spell.components			: ""
//
//		self.spell = spell
//	}

	func configure(for spellData: (expanded: Bool, spell: Spell)) {
		let spell 		= spellData.spell
		let expanded 	= spellData.expanded

		titleLabel.text 			= spell.name
		descriptionLabel.text		= spell.description()
		iconView.image				= UIImage(named: spell.school)

		componentLabel.text			= expanded ? spell.components			: ""

		self.spell = spell
	}
//	func open() {
//		print("will open: \(spell?.components)")
//		guard let spell = spell else { return }
//		componentLabel.text		= spell.components
//
//		print("did open")
//	}
//
//	func close() {
//		componentLabel.text		= ""
//	}

//	func toggle() {
//		if isSelected {
//			close()		}
//		else {
//			open()		}
//	}
}
