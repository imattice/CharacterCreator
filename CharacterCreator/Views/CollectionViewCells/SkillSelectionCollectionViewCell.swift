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

	func updateModifierLabel(to value: Int, animated: Bool) {
		modifierLabel.text = String(value)

		print("updated")
		if animated {
			UIView.transition(with: modifierLabel,
							  duration: 0.5,
							  options: [.curveEaseIn, .transitionFlipFromTop],
							  animations: { },
							  completion:  nil)
		}
	}

	func updateModifierWithProficiency(animated: Bool) {
		let currentValue = Int(modifierLabel.text!)!
		let proficiency = Character.default.proficiencyBonus
		var newValue: Int = 0
		if isSelected { newValue = currentValue + proficiency } else { newValue = currentValue - proficiency }

		updateModifierLabel(to: newValue, animated: true)
	}
}
