//
//  LanguageLabelCollectionViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class RemoveableLanguageLabelCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var xButton: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


class StaticLanguageLabelCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var titleLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//
//		config()
//	}
//	required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//
//		config()
//	}
//
//	func config() {
//		backgroundColor = .blue
//
//		layoutViews()
//	}
//
//	func layoutViews() {
//		contentView.addSubview(titleLabel)
//
//		titleLabel.translatesAutoresizingMaskIntoConstraints = false
//		let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[titleLabel]-8-|",
//									   options: .alignAllCenterY, metrics: nil,
//									   views: ["superview" : self, "titleLabel" : titleLabel])
//
//		addConstraints(horizontal)
//	}
}
