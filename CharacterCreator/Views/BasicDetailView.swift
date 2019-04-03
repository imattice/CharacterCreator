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

//	var imagePicker = UIImagePickerController()
//	let imagePickerDelegate: UIImagePickerControllerDelegate? = nil

	var imageSelectionDelegate: ImageSelectionDelegate?

	func nextTextView(_ currentTextField: UITextField) {
		switch currentTextField {
		case nameTextFieldView.textField:
			ageTextFieldView.textField.becomeFirstResponder()
		case ageTextFieldView.textField:
			appearanceTextAreaView.textView.becomeFirstResponder()
		default:
			break
		}
	}
	func nextTextView(_ currentTextView: UITextView) {
		switch currentTextView {
		case appearanceTextAreaView.textView:
			backstoryTextAreaView.textView.becomeFirstResponder()
		case backstoryTextAreaView.textView:
			backstoryTextAreaView.textView.resignFirstResponder()
		default:
			break
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

	func setCharacterDetail(_ textView: UITextView) {
		switch textView {
		case appearanceTextAreaView.textView:
			guard let appearance = textView.text else { break }
			Character.current.flavorText.appearance = appearance
		case backstoryTextAreaView.textView:
			guard let backstory = textView.text else { break }
			Character.current.flavorText.backstory = backstory
		default:
			break
		}
	}
	@IBAction func imageSelectionViewTapped(_ sender: UITapGestureRecognizer) {
		guard let delegate = imageSelectionDelegate else { return }

		delegate.selectImage()
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

extension BasicDetailView: UITextViewDelegate {

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
			switch textView {
			case appearanceTextAreaView.textView:
				appearanceTextAreaView.setPlaceholder()
			case backstoryTextAreaView.textView:
				backstoryTextAreaView.setPlaceholder()
			default:
				break
			}
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


}
