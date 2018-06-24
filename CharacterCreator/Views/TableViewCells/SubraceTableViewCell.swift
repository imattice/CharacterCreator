//
//  SubraceTableViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/23/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class SubraceTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var modifierLabel: UILabel!
	@IBOutlet weak var portraitImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configure(for race: String) {

	}
}
