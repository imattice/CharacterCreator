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
	@IBOutlet weak var componentLabel: UILabel!
	@IBOutlet weak var iconView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var castTimeLabel: UILabel!
	@IBOutlet weak var rangeLabel: UILabel!
	@IBOutlet weak var damageLabel: UILabel!


	func configure(for spell: Spell) {
		if let damage = spell.damage { 	damageLabel.text			= "💥:\(damage)" }
		else { 							damageLabel.text			= "" }

		titleLabel.text 			= spell.name
		descriptionLabel.text		= spell.description()
		iconView.image				= UIImage(named: spell.school)
		rangeLabel.text				= "🏹: \(spell.range)"
	}
}
