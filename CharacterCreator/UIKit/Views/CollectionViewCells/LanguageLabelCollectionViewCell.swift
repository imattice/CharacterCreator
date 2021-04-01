//
//  LanguageLabelCollectionViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

//@IBDesignable
class RemoveableLanguageLabelCollectionViewCell: LanguageLabelCollectioViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var xButton: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

//@IBDesignable
class StaticLanguageLabelCollectionViewCell: LanguageLabelCollectioViewCell {
	@IBOutlet weak var titleLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
}

//@IBDesignable
class LanguageLabelCollectioViewCell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)

		config()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}

	func config() {
		style()
	}

	func style() {
		backgroundColor		= Character.current.class.color().lightColor()
		layer.borderColor	= Character.current.class.color().darkColor().cgColor
		layer.borderWidth	= 2
		layer.cornerRadius	= 8
	}
}
