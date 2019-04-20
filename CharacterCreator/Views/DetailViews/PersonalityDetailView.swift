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

//	var idealsCustomText 	= ""
//	var flawsCustomText 	= ""
//	var bondsCustomText		= ""

	var delegate: AlertPresentationDelegate?

	lazy var pickerViewDataSource: [String]	= {
		guard let activeView = UIResponder.current else { return ["Decide Later"] }

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

		configureTextViews()
	}

	func configureTextViews() {
		let views = [idealsTextFieldView, flawsTextFieldView, bondsTextFieldView]

		for view in views {
			guard let view = view else { continue }

			view.textView.tintColor		= .clear
			view.textView.inputView		= pickerView
			view.textView.addToolbar(self, onOk: .okSelected, onCancel: .cancelSelected)
		}

		personalityTextAreaView.textView.addToolbar(self, onOk: .okSelected, onCancel: .cancelSelected)
	}

	@objc func okButtonSelected() {
		setCharacterDetail()

		resignResponder()
	}
	@objc func cancelButtonSelected() {
		if let responder = UIResponder.current as? UITextView,
			let superview = responder.superview as? TextAreaView {

			setPlaceholder(forView: superview)
		}

		resignResponder()
	}

	func resignResponder() {
		guard let responder = UIResponder.current else {	return }

		responder.resignFirstResponder()
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
//	func customText(forView view: TextAreaView) -> String? {
//		switch view {
//		case idealsTextFieldView: 	return idealsCustomText
//		case bondsTextFieldView: 	return bondsCustomText
//		case flawsTextFieldView:	return flawsCustomText
//		default:					return nil
//		}
//	}

	func setCharacterDetail() {
		guard let responder = UIResponder.current as? UITextView else { return }

		switch responder {
		case idealsTextFieldView:
			Character.current.flavorText.ideals 		= responder.text
		case bondsTextFieldView:
			Character.current.flavorText.bonds 			= responder.text
		case flawsTextFieldView:
			Character.current.flavorText.flaws 			= responder.text
		case personalityTextAreaView:
			Character.current.flavorText.personality 	= responder.text
		default:
			break
		}
	}

	enum PersonalityDetail: String {
		case ideals, bonds, flaws
	}
}

extension PersonalityDetailView: UIPickerViewDataSource, UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard let textView = UIResponder.current as? UITextView,
		let superview = textView.superview as? TextAreaView else { print("could not get responder"); return }
		switch row {
		case 0:
			textView.text = superview.placeholder
//		case pickerViewDataSource.count - 1:
//			view.textView.text = customText(forView: view)
//			delegate?.presentAlertController(forPersonalityDetail: view)
		default:
			textView.text = pickerViewDataSource[row]
		}
		if textView.text == superview.placeholder {
			textView.textColor = UIColor.lightGray		}
		else {
			textView.textColor = UIColor.black			}
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
		if textView != personalityTextAreaView.textView {
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

			if let index = pickerViewDataSource.firstIndex(of: textView.text) {
				pickerView.selectRow(index, inComponent: 0, animated: false)	}
			else {
				pickerView.selectRow(0, inComponent: 0, animated: false)			}

			pickerView.reloadAllComponents()
		}


		return true
	}

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView == personalityTextAreaView.textView && textView.text == personalityTextAreaView.placeholder	{
			textView.text = ""
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
	func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		guard let responder = UIResponder.current as? UITextView,
		let superview = responder.superview as? TextAreaView else { print("no responder "); return true }

		//no change was made
		if textView.text == superview.placeholder || textView.text == "" {
			setPlaceholder(forView: superview)
		}
		//changes were made
		else {

		}

		return true
	}
//	func textViewDidEndEditing(_ textView: UITextView) {
//		guard let responder = getCurrentResponderView() else { print("no responder "); return }
//
//		//no change was made
//		if textView.text == responder.placeholder || textView.text == "" {
//			setPlaceholder(forView: responder)
//		}
//		//changes were made
//		else {
//
//		}
//	}

	func setPlaceholder(forView view: TextAreaView) {
		view.textView.text			= view.placeholder
		view.textView.textColor		= .lightGray
	}
}

fileprivate extension Selector {
	static let okSelected 		= #selector(PersonalityDetailView.okButtonSelected)
	static let cancelSelected	= #selector(PersonalityDetailView.cancelButtonSelected)

}

