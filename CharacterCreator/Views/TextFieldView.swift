//
//  TextFieldView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/26/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

//@IBDesignable
class TextFieldView: UIView {
	@IBInspectable var placeholder: String?
	let textField 	= UITextField()

	private let underline 	= UIView()
	private let defaultFrame = CGRect(x: 0, y: 0, width: 150, height: 30)

	init(placeholder: String) {
		self.placeholder = placeholder
		super.init(frame: defaultFrame)

		config()  //this might crash, due to the object not created at time setting delegate in config
	}

	convenience init() {
		self.init(placeholder: "")
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}

	func config() {

		textField.placeholder = placeholder
		textField.delegate = self
		textField.translatesAutoresizingMaskIntoConstraints = false

		underline.backgroundColor = Character.default.class.color().darkColor()
		underline.translatesAutoresizingMaskIntoConstraints	= false

		addSubview(underline)
		addSubview(textField)

		layoutViews()
	}

	private func layoutViews() {
		let viewDict = ["underline": 	underline,
						"textField": 	textField,
						"self":			self ]
		let H_underline = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[underline]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_underline = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField][underline(3)]-4-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let H_textField = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textField]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_textField = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField(>=5)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let H_self = NSLayoutConstraint.constraints(withVisualFormat: "V:[self(50)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_underline + V_underline + H_textField + V_textField + H_self

		self.addConstraints(constraints)
	}
}

extension TextFieldView: UITextFieldDelegate {

}
