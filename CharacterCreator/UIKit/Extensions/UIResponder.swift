//
//  UIResponder.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/18/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

extension UIResponder {
	private weak static var currentFirstResponder: UIResponder? = nil

	public static var current: UIResponder? {
		UIResponder.currentFirstResponder = nil
		UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
		return UIResponder.currentFirstResponder
	}

	@objc internal func findFirstResponder(sender: AnyObject) {
		UIResponder.currentFirstResponder = self
	}
}
