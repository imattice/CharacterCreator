//
//  ExpandableTableViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/24/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var proficiencyLabel: UILabel!
	@IBOutlet weak var goldLabel: UILabel!
	@IBOutlet weak var itemsLabel: UILabel!
	@IBOutlet weak var reputationTitleLabel: UILabel!
	@IBOutlet weak var reputationLabel: UILabel!
	@IBOutlet weak var backgroundImageView: UIImageView!



	override func setSelected(_ selected: Bool, animated: Bool) {
		super .setSelected(selected, animated: animated)

		toggleExpansion()
	}

	func toggleExpansion() {
		if isSelected {

		}
	}
}
