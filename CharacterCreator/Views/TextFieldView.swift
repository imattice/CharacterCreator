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
	@IBInspectable var placeholder: String? {
		didSet {
			textField.placeholder = placeholder		}}
	let textField 	= UITextField()

	private let underline 	= UIView()
	private let defaultFrame = CGRect(x: 0, y: 0, width: 150, height: 30)

//	init(placeholder: String) {
//		self.placeholder = placeholder
//		super.init(frame: defaultFrame)
//
//		config()  //this might crash, due to the object not created at time setting delegate in config
//	}
//
//	convenience init() {
//		self.init(placeholder: "")
//	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}

	func config() {

		textField.placeholder = placeholder
		textField.delegate = self

		underline.backgroundColor = Character.default.class.color().darkColor()

		addSubview(underline)
		addSubview(textField)

		layoutViews()
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
}

extension TextFieldView: UITextFieldDelegate {

}

class ImageSelectionView: UIView {
	private let imageView = UIImageView()

	@IBInspectable var image: UIImage? {
		didSet {
			imageView.image = image		}}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}

	private func config() {
		backgroundColor = .brown

		addSubview(imageView)

		layoutViews()
	}

	private func layoutViews() {

		let viewDict = ["imageView"		: imageView,
						"self"			: self ]

		imageView.translatesAutoresizingMaskIntoConstraints = false
		let H_imageView = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[imageView(>=75)]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_imageView = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[imageView(>=75)]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_imageView + V_imageView

		self.addConstraints(constraints)
	}
}

class TextAreaView: UIView {
	@IBInspectable var placeHolder: String? {
		didSet {
				}}
	let textView = UITextView()
	let titleLabel = UILabel()


	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}

	private func config() {

		layoutViews()
	}

	private func layoutViews() {
		let viewDict = ["textView"		: textView,
						"self"			: self		]

		textView.translatesAutoresizingMaskIntoConstraints	= false
		let H_textView = NSLayoutConstraint.constraints(withVisualFormat: "", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_textView = NSLayoutConstraint.constraints(withVisualFormat: "", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_textView + V_textView

		self.addConstraints(constraints)
	}
}
