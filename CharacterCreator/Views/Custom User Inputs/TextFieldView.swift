//
//  TextFieldView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/26/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldView: UIView {
	let textField 	= UITextField()

	@IBOutlet var delegate: UITextFieldDelegate? {
		didSet {
			textField.delegate = delegate
		}}

	@IBInspectable var placeholder: String? {
		didSet {
			textField.placeholder = placeholder		}}


	private let underline 	= UIView()
	private let defaultFrame = CGRect(x: 0, y: 0, width: 150, height: 30)

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)

		config()
	}

	func config() {

		textField.placeholder = placeholder
		textField.addToolbar()

		underline.backgroundColor = Character.default.class.color().darkColor()

		addSubview(underline)
		addSubview(textField)

		layoutViews()

		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextFieldView.setResponder))
		self.addGestureRecognizer(tapRecognizer)
	}

	private func layoutViews() {
		let viewDict = ["underline": 	underline,
						"textField": 	textField,
						"self":			self ]

		underline.translatesAutoresizingMaskIntoConstraints	= false
		let H_underline = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[underline]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_underline = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField][underline(3)]-4-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		textField.translatesAutoresizingMaskIntoConstraints = false
		let H_textField = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textField]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_textField = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField(>=5)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_underline + V_underline + H_textField + V_textField

		self.addConstraints(constraints)
	}
	@objc private func setResponder() {
		textField.becomeFirstResponder()
	}
}
