//
//  SpellSelectionHeaderView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/13/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

//@IBDesignable
class SpellSelectionHeaderView: UIView {
	var view: UIView!

	@IBOutlet var levelViews: [UIView]!
	@IBOutlet weak var sliderView: UIView!
	@IBOutlet weak var spellCountLabel: UILabel!
	
	@IBOutlet weak var sliderLeftConstraint: NSLayoutConstraint!
	@IBOutlet weak var sliderHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var sliderWidthConstraint: NSLayoutConstraint!

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()

		setInitialSliderConstraints()

		sliderView.backgroundColor 	= UIColor.paintGradientColors()[0]
		sliderView.alpha			= 0.5


	}

	func shiftSlider(toSection section: Int) {
		let setColor = UIColor.paintGradientColors()

		sliderLeftConstraint.constant	= sliderWidthConstraint.constant * CGFloat(section)

		UIView.animate(withDuration: 0.25) {
			self.sliderView.backgroundColor = setColor[section]
			self.layoutIfNeeded()
		}
	}

	private func setInitialSliderConstraints() {
		let firstLevelView = levelViews[0]
		let width = firstLevelView.bounds.width
		let height = firstLevelView.bounds.height

		sliderHeightConstraint.constant = height
		sliderWidthConstraint.constant	= width
		sliderLeftConstraint.constant	= 0
	}
}
