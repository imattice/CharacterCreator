//
//  ChoiceContainerView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ChoiceSelectionView: UIView {
	var view: UIView!

	@IBOutlet weak var stackView: UIStackView!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		xibSetup()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		xibSetup()
	}
}
