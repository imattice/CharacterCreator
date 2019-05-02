//
//  ItemSelectionTableViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/31/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ItemSelectionTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var damageLabel: UILabel!
	@IBOutlet weak var tagLabel: UILabel!

	func configure(for item: Item) {
		titleLabel.text 			= item.name.capitalized

		descriptionLabel.text		= item.description()
	}

	func configure(for weapon: Weapon) {
		titleLabel.text			= weapon.name.capitalized
		descriptionLabel.text	= weapon.description()


		if let damage = item.damage() {
			damageLabel.text			= damage.rollString(withType: true)		}
		else {
			damageLabel.text			= "-" 											}

		var tagString = ""

		if let tags = item.tags {
			for tag in tags {
				tagString += "• \(tag.rawValue) "
			}
			tagString += "•"
		}
		tagLabel.text				= tagString
	}
    
}
