//
//  SocialDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/15/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

@IBDesignable
class SocialDetailView: XibView, LanguageSelectionDelegate {
	@IBOutlet weak var alignmentTextFieldView: TextFieldView!
//	@IBOutlet weak var languagesStackView: UIStackView!
	@IBOutlet weak var addLanguageBuggon: UIButton!
	@IBOutlet weak var relationshipsTextAreaView: TextAreaView!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
	
	let pickerView = UIPickerView()
	var presentationDelegate: LanguagePresentationDelegate?

	let availableSelections = Character.default.languages.innate.filter( { $0.name == "choice" }).count
	var selectedLanguages = [LanguageRecord]() {
		didSet {
			collectionView.reloadData()	}}
	var dataSource: [LanguageRecord] {
		return Character.default.languages.innate.filter( { $0.name != "choice" }) + selectedLanguages }



	override func config() {
		pickerView.delegate 	= self
		pickerView.dataSource 	= self
		relationshipsTextAreaView.textView.delegate	= self

		alignmentTextFieldView.textField.inputView = pickerView
		alignmentTextFieldView.tintColor			= .clear

		alignmentTextFieldView.textField.addToolbar(self, onOk: .okSelected, onCancel: .cancelSelected)
		relationshipsTextAreaView.textView.addToolbar(self, onOk: .okSelected, onCancel: .cancelSelected)

		let alignedLayout = collectionViewLayout as? AlignedCollectionViewFlowLayout
		alignedLayout?.horizontalAlignment	= .left
		alignedLayout?.verticalAlignment	= .top

		registerCells()
	}

	@objc func okSelected() {
		setCharacterDetail()

		UIResponder.current?.resignFirstResponder()
	}
	@objc func cancelSelected() {
		guard let responder = UIResponder.current else { return }

		switch responder {
		case alignmentTextFieldView.textField:
			pickerView.selectRow(0, inComponent: 0, animated: true)
			alignmentTextFieldView.textField.text = alignmentTextFieldView.placeholder
			alignmentTextFieldView.textField.textColor = UIColor.lightGray

		default:
			break
		}

		responder.resignFirstResponder()
	}

	func setCharacterDetail() {
		guard let responder = UIResponder.current else { return }

		switch responder {
		case alignmentTextFieldView.textField as UITextField:
			guard let alignment = alignmentTextFieldView.textField.text else { return }
			Character.current.flavorText.alignment = alignment

		case relationshipsTextAreaView.textView as UITextView:
			guard let relationships = relationshipsTextAreaView.textView.text else { return }
			Character.current.flavorText.relationships	= relationships
		default:
			break
		}
	}

	@IBAction func addLaguage(_ sender: UIButton) {
		presentationDelegate?.presentLanguageSelection(withSelections: availableSelections)
	}
	func removeLanguage(atIndex index: Int) {
		selectedLanguages.remove(at: index)
	}
}

extension SocialDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.LanguageLabelCell.rawValue, for: indexPath) as! LanguageLabelCollectionViewCell
			cell.titleLabel.text	= dataSource[indexPath.row].name

			cell.titleLabel.sizeToFit()
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		removeLanguage(atIndex: indexPath.row)

		collectionView.reloadData()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource.count
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let margins = CGFloat(8*3) + 20  //constrant margins + width constraint of x button

		let label = UILabel()
		label.text = dataSource[indexPath.row].name
		label.font = UIFont.systemFont(ofSize: 14)
		label.sizeToFit()

		return CGSize(width: label.frame.width + margins, height: 30)
	}
	private func registerCells() {
		collectionView.register(UINib(nibName: String(describing: LanguageLabelCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CellIdentifier.LanguageLabelCell.rawValue)
	}

	struct CollectionViewData {
		let isRemovable: Bool
		let source: String
		let language: LanguageRecord

		enum LanguageSource: String {
			case race 	= "R",
			background 	= "B",
			`class`		= "C"
		}

	}
}

extension SocialDetailView: UITextViewDelegate {
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
			relationshipsTextAreaView.setPlaceholder()
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

protocol LanguagePresentationDelegate {
	func presentLanguageSelection(withSelections selections: Int)
}
protocol LanguageSelectionDelegate {
	var selectedLanguages: [LanguageRecord] { get set }
}
fileprivate extension Selector {
	static let okSelected = #selector(SocialDetailView.okSelected)
	static let cancelSelected = #selector(SocialDetailView.cancelSelected)

}

fileprivate enum CellIdentifier: String {
	case LanguageLabelCell
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
