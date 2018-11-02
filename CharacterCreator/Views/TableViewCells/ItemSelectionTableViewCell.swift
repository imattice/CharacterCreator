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
		titleLabel.text 			= item.name
		descriptionLabel.text 		= item.description()
		damageLabel.text			= item.damage()

		let tagString = ""
		tagLabel.text				= tagString
	}
    
}
