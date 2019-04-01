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

	var imageSelectionDelegate: ImageSelectionDelegate? {
		didSet{
			print("image selection delegate was updated to \(imageSelectionDelegate)") }}

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
	@IBAction func imageSelectionViewTapped(_ sender: UITapGestureRecognizer) {
		print("pretap")
		print(imageSelectionDelegate)

		guard let delegate = imageSelectionDelegate else { return }
		print("tapped")

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

extension BasicDetailView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

}
