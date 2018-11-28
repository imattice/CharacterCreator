//
//  TextFieldView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/26/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
	var placeholder: String? = "name"

	private let textField 	= UITextField()
	private let underline 	= UIView()

	func config() {

		textField.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
		textField.placeholder = placeholder
		textField.delegate = self
		textField.translatesAutoresizingMaskIntoConstraints = false


//		underline.frame = CGRect(x: 0, y: 0, width: 0, height: )
		underline.backgroundColor = .red
		underline.translatesAutoresizingMaskIntoConstraints	= false


		addSubview(underline)
		addSubview(textField)

		layoutViews()
	}

	private func layoutViews() {
		let underlineDict = ["underline": underline,
							 "textField": textField]
		let H_underline = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[underline]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: underlineDict)
		let V_underline = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField][underline(3)]-4-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: underlineDict)

		let H_textField = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textField]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: underlineDict)
		let V_textField = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField(>=5)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: underlineDict)

		let constraints = H_underline + V_underline + H_textField + V_textField

		self.addConstraints(constraints)
	}
}

extension TextFieldView: UITextFieldDelegate {

}
