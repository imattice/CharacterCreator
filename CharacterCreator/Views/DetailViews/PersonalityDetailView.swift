//
//  PersonalityDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/4/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

protocol AlertPresentationDelegate {
	func presentAlertController(forPersonalityDetail textAreaView: TextAreaView)
}

@IBDesignable
class PersonalityDetailView: XibView {
	@IBOutlet weak var idealsTextFieldView: TextAreaView!
	@IBOutlet weak var flawsTextFieldView: TextAreaView!
	@IBOutlet weak var bondsTextFieldView: TextAreaView!
	@IBOutlet weak var personalityTextAreaView: TextAreaView!

	let pickerView = UIPickerView()

	var idealsCustomText 	= ""
	var flawsCustomText 	= ""
	var bondsCustomText		= ""

	var delegate: AlertPresentationDelegate?

	lazy var pickerViewDataSource: [String]	= {
		guard let activeView = getCurrentResponderView() else { return ["Decide Later"] }

		switch activeView {
		case idealsTextFieldView.textView:
			return dataSource(forPersonalityDetail: .ideals)
		case flawsTextFieldView.textView:
			return dataSource(forPersonalityDetail: .flaws)
		case bondsTextFieldView.textView:
			return dataSource(forPersonalityDetail: .bonds)
		default:
			return ["Decide Later"]
		}
	}()


	override func config() {
		pickerView.dataSource 	= self
		pickerView.delegate		= self

		idealsTextFieldView.textView.inputView			= pickerView
		flawsTextFieldView.textView.inputView			= pickerView
		bondsTextFieldView.textView.inputView			= pickerView
		
	}

	func getCurrentResponderView() -> TextAreaView? {
		if idealsTextFieldView.textView.isFirstResponder {
			return idealsTextFieldView
		}
		else if flawsTextFieldView.textView.isFirstResponder {
			return flawsTextFieldView
		}
		else if bondsTextFieldView.textView.isFirstResponder {
			return bondsTextFieldView
		}
		else if personalityTextAreaView.textView.isFirstResponder {
			return personalityTextAreaView
		}
		else {
			return nil
		}
	}

	func updateDataSource(forPersonalityDetail detail: PersonalityDetail) {
		guard let background = Character.default.background,
			let backgroundData = backgroundData[background.name.lowercased()] as? [String: Any],
			let dict = backgroundData[detail.rawValue.lowercased()] as? [String] else { print("something broke here"); return }

		pickerViewDataSource = ["Decide Later"]
		dict.forEach {
			pickerViewDataSource.append($0)
		}
//		pickerViewDataSource.append("Custom")
	}

	func dataSource(forPersonalityDetail detail: PersonalityDetail) -> [String] {
		var result = ["Decide Later"]

		guard let background = Character.default.background,
			let backgroundData = backgroundData[background.name.lowercased()] as? [String: Any],
			let dict = backgroundData[detail.rawValue.lowercased()] as? [String] else { print("something broke here"); return result }

		dict.forEach {
			result.append($0)
		}
//		result.append("Custom")

		return result
	}
	func customText(forView view: TextAreaView) -> String? {
		switch view {
		case idealsTextFieldView: 	return idealsCustomText
		case bondsTextFieldView: 	return bondsCustomText
		case flawsTextFieldView:	return flawsCustomText
		default:					return nil
		}
	}

	enum PersonalityDetail: String {
		case ideals, bonds, flaws
	}
}

extension PersonalityDetailView: UIPickerViewDataSource, UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard let view = getCurrentResponderView() else { print("could not get responder"); return }
		switch row {
		case 0:
			view.textView.text = view.placeholder
//		case pickerViewDataSource.count - 1:
//			view.textView.text = customText(forView: view)
//			delegate?.presentAlertController(forPersonalityDetail: view)
		default:
			view.textView.text = pickerViewDataSource[row]
		}
	}
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerViewDataSource.count	}

	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20 , height: 44));
		label.lineBreakMode = .byTruncatingTail;
		label.numberOfLines = 4;
		label.text = pickerViewDataSource[row]
		label.sizeToFit()
		return label;
	}
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 80
	}
}

extension PersonalityDetailView: UITextViewDelegate {
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		switch textView {
		case idealsTextFieldView.textView:
			updateDataSource(forPersonalityDetail: .ideals)
		case bondsTextFieldView.textView:
			updateDataSource(forPersonalityDetail: .bonds)
		case flawsTextFieldView.textView:
			updateDataSource(forPersonalityDetail: .flaws)
		default:
			break
		}

		pickerView.reloadAllComponents()

		return true
	}
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
			case idealsTextFieldView.textView:
				idealsTextFieldView.setPlaceholder()
			case bondsTextFieldView.textView:
				bondsTextFieldView.setPlaceholder()
			case flawsTextFieldView.textView:
				flawsTextFieldView.setPlaceholder()
			case personalityTextAreaView.textView:
				personalityTextAreaView.setPlaceholder()
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
//		setCharacterDetail(textView)
	}
}

