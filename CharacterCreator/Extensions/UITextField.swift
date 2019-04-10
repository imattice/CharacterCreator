//
//  UITextField.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/2/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

extension UITextField {
	func addToolbar(leftButton: (title: String, target: Any, action: Selector)? = nil, rightButton: (title: String, target: Any, action: Selector)? = nil) {
		let toolbar: UIToolbar = UIToolbar()
		toolbar.barStyle = .default

		var buttons = [UIBarButtonItem]()

		if let leftButton	= leftButton {
			buttons.append(UIBarButtonItem(title: leftButton.title, style: .plain, target: leftButton.target, action: leftButton.action))
		}

		buttons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))

		if let rightButton	= rightButton {
			buttons.append(UIBarButtonItem(title: rightButton.title, style: .plain, target: rightButton.target, action: rightButton.action))
		}

		toolbar.items = buttons

		toolbar.sizeToFit()

		//if there was at least 1 button added, add the toolbar
		if buttons.count > 1 {
			self.inputAccessoryView = toolbar
		}
	}

	func addToolbar(_ target: Any, onOk okAction: Selector?, onCancel cancelAction: Selector?) {
		let leftAction 	= okAction ?? .leftButtonTapped
		let rightAction = cancelAction ?? .rightButtonTapped

		addToolbar(leftButton: (title: "Ok", target: target, action: leftAction), rightButton: (title: "Cancel", target: target, action: rightAction))
	}

	@objc func leftButtonTapped()	{ self.resignFirstResponder() }
	@objc func rightButtonTapped()	{ self.resignFirstResponder() }
}

fileprivate extension Selector {
	static let leftButtonTapped 	= #selector(UITextField.leftButtonTapped)
	static let rightButtonTapped 	= #selector(UITextField.rightButtonTapped)
}
