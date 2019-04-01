//
//  BasicDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 3/29/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

class BasicDetailView: XibView {
	@IBOutlet weak var imageSelectionView: ImageSelectionView!
	@IBOutlet weak var nameTextFieldView: TextFieldView!
	@IBOutlet weak var ageTextFieldView: TextFieldView!
	@IBOutlet weak var appearanceTextAreaView: TextAreaView!
	@IBOutlet weak var backstoryTextAreaView: TextAreaView!

	func nextTextView(_ currentTextField: UITextField) {
		switch currentTextField {
		case nameTextFieldView.textField:
			ageTextFieldView.textField.becomeFirstResponder()
		case ageTextFieldView.textField:
			nameTextFieldView.textField.becomeFirstResponder()
		default:
			print("didn't work")
		}
	}

	func setCharacterDetail(_ textField: UITextField) {
		switch textField {
		case nameTextFieldView.textField:
			guard let name = textField.text else { break }
			Character.current.flavorText.name = name
		case ageTextFieldView.textField:
			guard let age = textField.text else { break }
			Character.current.flavorText.age = age
		default:
			break
		}
	}
}

extension BasicDetailView: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		setCharacterDetail(textField)

		resignFirstResponder()
		nextTextView(textField)

		return true
	}
}
