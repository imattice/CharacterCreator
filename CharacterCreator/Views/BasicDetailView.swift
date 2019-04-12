//
//  BasicDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 3/29/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class BasicDetailView: XibView {
	@IBOutlet weak var imageSelectionView: ImageSelectionView!
	@IBOutlet weak var nameTextFieldView: TextFieldView!
	@IBOutlet weak var ageTextFieldView: TextFieldView!
	@IBOutlet weak var appearanceTextAreaView: TextAreaView!
	@IBOutlet weak var backstoryTextAreaView: TextAreaView!

	var imageSelectionDelegate: ImageSelectionDelegate?

	override func config() {
		super.config()
		
		addNotificationObservers()

		ageTextFieldView.textField.keyboardType	= .decimalPad
	}

	func addNotificationObservers() {
		NotificationCenter.default.addObserver(self, selector: .keyboardWillChange, name: UIResponder.keyboardWillShowNotification , object: nil)
		NotificationCenter.default.addObserver(self, selector: .keyboardWillChange, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: .keyboardWillChange, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	func getCurrentResponder() -> Any? {
		if nameTextFieldView.textField.isFirstResponder {
			return nameTextFieldView.textField as Any
		}
		else if ageTextFieldView.textField.isFirstResponder {
			return ageTextFieldView.textField as Any
		}
		else if appearanceTextAreaView.textView.isFirstResponder {
			return appearanceTextAreaView.textView as Any
		}
		else if backstoryTextAreaView.textView.isFirstResponder {
			return backstoryTextAreaView.textView as Any
		}
		else {
			return nil
		}
	}

//	func nextTextView(_ currentTextField: UITextField) {
//		switch currentTextField {
//		case nameTextFieldView.textField:
//			ageTextFieldView.textField.becomeFirstResponder()
//		case ageTextFieldView.textField:
//			appearanceTextAreaView.textView.becomeFirstResponder()
//		default:
//			break
//		}
//	}
//	func nextTextView(_ currentTextView: UITextView) {
//		switch currentTextView {
//		case appearanceTextAreaView.textView:
//			backstoryTextAreaView.textView.becomeFirstResponder()
//		case backstoryTextAreaView.textView:
//			backstoryTextAreaView.textView.resignFirstResponder()
//		default:
//			break
//		}
//	}

	func nextTextView() {
		guard let responder = getCurrentResponder() else { return }

		switch responder {
		case nameTextFieldView.textField as UITextField:
			ageTextFieldView.textField.becomeFirstResponder()
		case ageTextFieldView.textField as UITextField:
			appearanceTextAreaView.textView.becomeFirstResponder()
		case appearanceTextAreaView.textView as UITextView:
			backstoryTextAreaView.textView.becomeFirstResponder()
		case backstoryTextAreaView.textView as UITextView:
			backstoryTextAreaView.textView.resignFirstResponder()
		default:
			break
		}
	}

	func setCharacterDetail() {
		guard let responder = getCurrentResponder() else { return }
		print("responder: \(responder)")
		switch responder {
		case nameTextFieldView.textField as UITextField:
			guard let textField = responder as? UITextField,
				let name = textField.text else { break }
			Character.current.flavorText.name = name
		case ageTextFieldView.textField as UITextField:
			guard let textField = responder as? UITextField,
				let age = textField.text else { print("no age"); break }
			Character.current.flavorText.age = age
			print("age set: \(Character.current.flavorText.age)")
		case appearanceTextAreaView.textView as UITextView:
			guard let textView = responder as? UITextView,
				let appearance = textView.text else { break }
			Character.current.flavorText.appearance = appearance
		case backstoryTextAreaView.textView as UITextView:
			guard let textView = responder as? UITextView,
				let backstory = textView.text else { break }
			Character.current.flavorText.backstory = backstory
		default:
			print("broke")
			break
		}
		print("age: \(Character.current.flavorText.age) /name: \(Character.current.flavorText.name)")
	}

//	func setCharacterDetail(_ textField: UITextField) {
//		switch textField {
//		case nameTextFieldView.textField:
//			guard let name = textField.text else { break }
//			Character.current.flavorText.name = name
//		case ageTextFieldView.textField:
//			guard let age = textField.text else { break }
//			Character.current.flavorText.age = age
//		default:
//			break
//		}
//	}
//
//	func setCharacterDetail(_ textView: UITextView) {
//		switch textView {
//		case appearanceTextAreaView.textView:
//			guard let appearance = textView.text else { break }
//			Character.current.flavorText.appearance = appearance
//		case backstoryTextAreaView.textView:
//			guard let backstory = textView.text else { break }
//			Character.current.flavorText.backstory = backstory
//		default:
//			break
//		}
//	}

	@objc func keyboardWillChange(_ notification: Notification) {
		guard let keyboardRect  = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

		if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
			let currentResponder = getCurrentResponder()
			switch currentResponder {
			case nameTextFieldView.textField as UITextField:
				self.frame.origin.y = 0
			case ageTextFieldView.textField as UITextField:
				self.frame.origin.y = 0
			case appearanceTextAreaView.textView as UITextView:
				self.frame.origin.y = -(nameTextFieldView.frame.height + ageTextFieldView.frame.height)*0.75
			case backstoryTextAreaView.textView as UITextView:
				self.frame.origin.y = -(keyboardRect.height*0.75)
			default:
				break
			}
		} else {
			self.frame.origin.y = 0
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
		setCharacterDetail()

		resignFirstResponder()
		nextTextView()
//		nextTextView(textField)

		return true
	}
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		setCharacterDetail()

		return true
	}
}

extension BasicDetailView: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView) {
	}
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
	func textViewDidEndEditing(_ textView: UITextView) {
		setCharacterDetail()
	}
}

fileprivate extension Selector {
	static let keyboardWillChange = #selector(BasicDetailView.keyboardWillChange(_:))
}
