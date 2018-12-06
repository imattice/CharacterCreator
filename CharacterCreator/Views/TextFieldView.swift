//
//  TextFieldView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/26/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

//Taking a break on this app.  Here is where I'm leaving the project
//added the delgates to this flavor container view, but I'm not sure if the ower should be the controller or the actual views.  Currently attempting to make the View Controller to be the delegate for all of these items.

class FlavorContainerView: UIView {
	@IBOutlet var textFieldDelegate: UITextViewDelegate?
	@IBOutlet var textViewDelegate: UITextViewDelegate?
	@IBOutlet var imagePickerDelegate: UIImagePickerControllerDelegate?
}

//@IBDesignable
class TextFieldView: UIView {
	let textField 	= UITextField()

	var delegate: UITextFieldDelegate?

	@IBInspectable var placeholder: String? {
		didSet {
			textField.placeholder = placeholder		}}


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

	var delegate: UIImagePickerControllerDelegate?

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
	let textView = UITextView()
	let titleLabel = UILabel()

	var delegate: UITextViewDelegate?

	@IBInspectable var title: String? {
		didSet {
			titleLabel.text = title		}}
	@IBInspectable var placeholder: String? {
		didSet {
			setPlaceholder()			}}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}

	private func config() {

		textView.delegate = self

		self.addSubview(titleLabel)
		self.addSubview(textView)

		layoutViews()
	}

	private func layoutViews() {
		let viewDict = ["textView"		: textView,
						"titleLabel"	: titleLabel,
						"self"			: self		]

		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		let H_titleLabel = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_titleLabel = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[titleLabel]-8-[textView(>=40)]-8-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		textView.translatesAutoresizingMaskIntoConstraints	= false
		let H_textView = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[textView]-8-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
//		let V_textView = NSLayoutConstraint.constraints(withVisualFormat: "", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_textView + H_titleLabel + V_titleLabel

		self.addConstraints(constraints)
	}
}

extension TextAreaView: UITextViewDelegate {

	func textViewDidChangeSelection(_ textView: UITextView) {
		if textView.textColor == UIColor.lightGray {
			textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
		}
	}

	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let currentText:String = textView.text
		let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

		//if updated text view will be empty, add the placeholder
		if updatedText.isEmpty {
			setPlaceholder()
		}

		//remove the placeholder if the user is about to add text
		else if textView.textColor == UIColor.lightGray && !text.isEmpty {
			textView.textColor = UIColor.black
			textView.text = text
		}
		// For every other case, the text should change with the usual behavior...
		else {
			return true		}

		// ...otherwise return false since the updates have already been made
		return false
	}

	//Placeholder Functions
	func setPlaceholder() {
		textView.text 		= placeholder
		textView.textColor	= .lightGray

		textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
	}
}
