//
//  ClassHeaderView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable class ClassHeaderView: UIView {
	var view: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var hitDieLabel: UILabel!

	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}

}
