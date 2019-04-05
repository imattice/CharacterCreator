//
//  UITextView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/2/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

extension UITextView {

	func addToolbar(onCancel: (target: Any, action: Selector)? = nil) {
		let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))

		let toolbar: UIToolbar = UIToolbar()
		toolbar.barStyle = .default

		toolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
		]
		toolbar.sizeToFit()

		self.inputAccessoryView = toolbar
	}


	@objc func cancelButtonTapped() { self.resignFirstResponder() }
}

