//
//  LanguageLabelCollectionViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class LanguageLabelCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var xButton: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		backgroundColor = .blue
    }
}
