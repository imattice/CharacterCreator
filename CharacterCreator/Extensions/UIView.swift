//
//  UIView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit


extension UIView {
	public func xibSetup() {
		let view = loadViewFromNib()

		// use bounds not frame or it'll be offset
		view.frame = bounds

		// Make the view stretch with containing view
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

		// Adding custom subview on top of our view (over any custom drawing > see note below)
		addSubview(view)
	}

	private func loadViewFromNib() -> UIView {

		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

		return view
	}
}
