//
//  SelectionPickerView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/4/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class SelectionPickerView: UIView {
	let titleLabel 			= UILabel()
	let pickerResultLabel 	= UILabel()
	let pickerView			= UIPickerView()

	@IBOutlet var delegate: UIPickerViewDelegate? {
		didSet {
			pickerView.delegate = delegate		}}
	@IBOutlet var dataSource: UIPickerViewDataSource? {
		didSet {
			pickerView.dataSource = dataSource		}}

	@IBInspectable var title: String? {
		didSet {
			titleLabel.text = title		}}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)

		config()
	}

	private func config() {
		pickerResultLabel.numberOfLines = 2
		pickerResultLabel.adjustsFontSizeToFitWidth = true
		pickerResultLabel.font	= UIFont.systemFont(ofSize: 14, weight: .medium)

		self.addSubview(titleLabel)
		self.addSubview(pickerResultLabel)

		layoutViews()

		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectionPickerView.showPicker))
		self.addGestureRecognizer(tapRecognizer)
	}

	private func layoutViews() {
		let viewDict = ["pickerResultLabel"		: pickerResultLabel,
						"titleLabel"			: titleLabel,
						"self"					: self		]

		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		let H_titleLabel = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_titleLabel = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[titleLabel]-8-[pickerResultLabel(>=40)]-8-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		pickerResultLabel.translatesAutoresizingMaskIntoConstraints	= false
		let H_textView = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[pickerResultLabel]-8-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		//		let V_textView = NSLayoutConstraint.constraints(withVisualFormat: "", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_textView + H_titleLabel + V_titleLabel

		self.addConstraints(constraints)
	}

	@objc func showPicker() {

	}
}
