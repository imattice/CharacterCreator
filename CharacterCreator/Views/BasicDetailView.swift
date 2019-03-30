//
//  BasicDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 3/29/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

class BasicDetailView: XibView {
	@IBOutlet var textFieldDelegate: UITextViewDelegate?
	@IBOutlet var textViewDelegate: UITextViewDelegate?
	@IBOutlet var imagePickerDelegate: UIImagePickerControllerDelegate?
	
	@IBOutlet weak var imageSelectionView: ImageSelectionView!
	@IBOutlet weak var nameTextFieldView: TextFieldView!
	@IBOutlet weak var ageTextFieldView: TextFieldView!
	@IBOutlet weak var appearanceTextAreaView: TextAreaView!
	@IBOutlet weak var backstoryTextAreaView: TextAreaView!

	func nextTextView() {

	}
}
