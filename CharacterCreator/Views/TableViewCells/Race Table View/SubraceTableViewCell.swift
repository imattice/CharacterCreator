//
//  ParentRaceTableViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/25/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class SubraceTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var modifierLabel: UILabel!
	

	var isExpanded: Bool = false
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
