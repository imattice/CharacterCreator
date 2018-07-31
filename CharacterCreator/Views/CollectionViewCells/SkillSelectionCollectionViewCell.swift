//
//  SkillSelectionCollectionViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class SkillSelectionCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var modifierLabel: UILabel!

	override var isSelected: Bool { didSet { setBackground() }}
	var isAvailable: Bool = false { didSet { setBackground() }}



	override func awakeFromNib() {
		super.awakeFromNib()

		contentView.layer.borderWidth = 3
		contentView.layer.borderColor = UIColor.black.cgColor

		setBackground()
	}

	func setBackground() {
		var backgroundColor: UIColor = .lightGray

		if isAvailable {
			backgroundColor = UIColor.lightestShadeForCurrentClass()
		}
		if isSelected {
			backgroundColor = UIColor.colorForCurrentClass()
		}

		UIView.transition(with: contentView,
						  duration: 0.25,
						  options: .transitionCrossDissolve,
						  animations: {
							self.contentView.backgroundColor = backgroundColor

							self.contentView.setTextColor()
		},
						  completion: nil)
	}

}
