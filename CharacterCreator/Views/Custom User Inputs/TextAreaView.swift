//
//  TextAreaView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/4/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class TextAreaView: UIView {
	let textView = UITextView()
	let titleLabel = UILabel()

	@IBOutlet var delegate: UITextViewDelegate? {
		didSet {
			textView.delegate = delegate		}}

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
	override init(frame: CGRect) {
		super.init(frame: frame)

		config()
	}

	private func config() {
		textView.textContainer.lineBreakMode	= .byTruncatingTail

		self.addSubview(titleLabel)
		self.addSubview(textView)

		layoutViews()

		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextAreaView.setResponder))
		self.addGestureRecognizer(tapRecognizer)
	}
	@objc func test() {
		print("test")
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
	func setPlaceholder() {
		textView.text 		= placeholder
		textView.textColor	= .lightGray

		textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
	}
	@objc private func setResponder() {
		textView.becomeFirstResponder()
	}
}
