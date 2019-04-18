//
//  SocialDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/15/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

class SocialDetailView: XibView {
	@IBOutlet weak var alignmentTextFieldView: TextFieldView!
	@IBOutlet weak var languagesStackView: UIStackView!
	@IBOutlet weak var addLanguageBuggon: UIButton!
	@IBOutlet weak var relationshipsTextAreaView: TextAreaView!

	let pickerView = UIPickerView()

	override func config() {
		pickerView.delegate 	= self
		pickerView.dataSource 	= self

		alignmentTextFieldView.textField.inputView = pickerView

		alignmentTextFieldView.textField.addToolbar(self, onOk: .okSelected, onCancel: .cancelSelected)
		relationshipsTextAreaView.textView.addToolbar(self, onOk: .okSelected, onCancel: .cancelSelected)
	}

	@objc func okSelected() {
		setCharacterDetail()

		alignmentTextFieldView.textField.resignFirstResponder()
	}

	@objc func cancelSelected() {
		alignmentTextFieldView.textField.resignFirstResponder()
	}

	func setCharacterDetail() {
		
	}

	@IBAction func addLaguage(_ sender: UIButton) {
	}
}

extension SocialDetailView: UIPickerViewDelegate, UIPickerViewDataSource {
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch row {
		case 0:
			alignmentTextFieldView.textField.text = alignmentTextFieldView.placeholder
		default:
			alignmentTextFieldView.textField.text = alignments[row]
		}

		//set the text color
		if alignmentTextFieldView.textField.text == alignmentTextFieldView.placeholder {
			alignmentTextFieldView.textField.textColor = UIColor.lightGray		}
		else {
			alignmentTextFieldView.textField.textColor = UIColor.black			}
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return alignments[row]
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return alignments.count	}
}

fileprivate extension Selector {
	static let okSelected = #selector(SocialDetailView.okSelected)
	static let cancelSelected = #selector(SocialDetailView.cancelSelected)

}

fileprivate var alignments = [
	"Decide Later",
	"Lawful Good",
	"Neutral Good",
	"Chaotic Good",
	"Lawful Neutral",
	"True Neutral",
	"Chaotic Neutral",
	"Lawful Evil",
	"Neutral Evil",
	"Chaotic Evil"
]
