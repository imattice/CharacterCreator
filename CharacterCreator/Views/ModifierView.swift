//
//  ModifierView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class ModifierView: UIView {
	@IBOutlet weak var sourceLabel: UILabel!
	@IBOutlet weak var modifierLabel: UILabel!

	var view: UIView!

	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
}
