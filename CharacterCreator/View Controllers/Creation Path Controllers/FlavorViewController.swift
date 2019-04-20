//
//  FlavorViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/3/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//ideals, bonds and flaws, personality PersonalityDetailView
//alignment, languages, relationships  SocialDetailView


import UIKit

class FlavorViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet var flavorViews: [UIView]!
	@IBOutlet weak var basicDetailView: BasicDetailView!
	@IBOutlet weak var personalityDetailView: PersonalityDetailView!

	let imagePicker = UIImagePickerController()

	let colors: [UIColor] = [.red, .yellow, .green, .blue]

	override func viewDidLoad() {
        super.viewDidLoad()

		configureViews()

		configureScrollView()

		basicDetailView.imageSelectionDelegate  = self
		personalityDetailView.delegate			= self

		addNotificationObservers()
    }

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	private func configureScrollView() {
		//Scroll View
		scrollView.delegate 						= self
		scrollView.isPagingEnabled 					= true
		scrollView.contentSize 						= CGSize(width: view.frame.width * CGFloat(flavorViews.count),
																height: view.frame.height)
		scrollView.showsHorizontalScrollIndicator	= false
		scrollView.alwaysBounceHorizontal 			= false
		scrollView.isDirectionalLockEnabled 		= true
		scrollView.bounces							= false

		//Page Control
		pageControl.numberOfPages 					= flavorViews.count
		pageControl.pageIndicatorTintColor 			= Character.default.class.color().lightColor()
		pageControl.currentPageIndicatorTintColor 	= Character.default.class.color().base()

	}

	private func configureViews() {
		for (index, flavorView) in flavorViews.enumerated() {

			flavorView.frame.size.width 	= self.view.frame.size.width
			flavorView.frame.size.height	= self.view.frame.size.height - 125 //subtracting the height of the safe area, the page control and its vertical constraints
			flavorView.layer.borderColor 	= UIColor.black.cgColor
			flavorView.layer.borderWidth 	= 3.0

			flavorView.frame.origin.x		= CGFloat(index) * self.view.bounds.size.width
			flavorView.frame.origin.y		= self.view.frame.origin.y

			flavorView.backgroundColor 		= colors[index]
			scrollView.addSubview(flavorView)

			flavorView.setNeedsDisplay()
		}
	}


	func addNotificationObservers() {
		NotificationCenter.default.addObserver(self, selector: .keyboardWillChange, name: UIResponder.keyboardWillShowNotification , object: nil)
		NotificationCenter.default.addObserver(self, selector: .keyboardWillChange, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: .keyboardWillChange, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
	}

	@objc func keyboardWillChange(_ notification: Notification) {
		guard let keyboardRect  = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

		if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
			let currentResponder = getCurrentResponder()
			switch currentResponder {
				//basicDetail
			case basicDetailView.nameTextFieldView.textField as UITextField,
				 basicDetailView.ageTextFieldView.textField as UITextField:
				basicDetailView.frame.origin.y = 0
			case basicDetailView.appearanceTextAreaView.textView as UITextView:
				basicDetailView.frame.origin.y = -(basicDetailView.nameTextFieldView.frame.height + basicDetailView.ageTextFieldView.frame.height)*0.75
			case basicDetailView.backstoryTextAreaView.textView as UITextView:
				basicDetailView.frame.origin.y = -(keyboardRect.height*0.75)

			//personalityDetailView positioning
			case personalityDetailView.idealsTextFieldView.textView as UITextView,
				 personalityDetailView.bondsTextFieldView.textView as UITextView,
				 personalityDetailView.flawsTextFieldView.textView as UITextView:
				personalityDetailView.frame.origin.y = 0
			case personalityDetailView.personalityTextAreaView.textView	as UITextView:
				personalityDetailView.frame.origin.y = -(keyboardRect.height*0.75)

			default:
				break
			}
		} else {
			basicDetailView.frame.origin.y = 0
			personalityDetailView.frame.origin.y = 0
		}
	}

	func getCurrentResponder() -> Any? {
		if basicDetailView.nameTextFieldView.textField.isFirstResponder {
			return basicDetailView.nameTextFieldView.textField as Any
		}
		else if basicDetailView.ageTextFieldView.textField.isFirstResponder {
			return basicDetailView.ageTextFieldView.textField as Any
		}
		else if basicDetailView.appearanceTextAreaView.textView.isFirstResponder {
			return basicDetailView.appearanceTextAreaView.textView as Any
		}
		else if basicDetailView.backstoryTextAreaView.textView.isFirstResponder {
			return basicDetailView.backstoryTextAreaView.textView as Any
		}

		else if personalityDetailView.idealsTextFieldView.textView.isFirstResponder {
			return personalityDetailView.idealsTextFieldView.textView as Any
		}
		else if personalityDetailView.bondsTextFieldView.textView.isFirstResponder {
			return personalityDetailView.bondsTextFieldView.textView as Any
		}
		else if personalityDetailView.flawsTextFieldView.textView.isFirstResponder {
			return personalityDetailView.flawsTextFieldView.textView as Any
		}
		else if personalityDetailView.personalityTextAreaView.textView.isFirstResponder {
			return personalityDetailView.personalityTextAreaView.textView as Any
		}
		else {
			return nil
		}
	}
}
extension FlavorViewController: AlertPresentationDelegate {
	func presentAlertController(forPersonalityDetail textAreaView: TextAreaView) {
		let alertController = UIAlertController(title: textAreaView.title, message: textAreaView.placeholder, preferredStyle: .alert)
		alertController.addTextField { textField in

			//check if the text that is currently in the view matches the default placeholder text
			//if not, fill the field with the user's previously entered custom text
			let previousText = textAreaView.textView.text
			if previousText != textAreaView.placeholder {
				
				textField.placeholder = textAreaView.textView.text
			}
		}
		//unwrap a reference to the text field for future use
		guard let textFields = alertController.textFields,
			let textField = textFields.first  else { return }

		//SAVE ACTION
		let saveAction = UIAlertAction(title: "OK", style: .default) { (action) in
			guard let userInput = textField.text else { return }

			textAreaView.textView.text = userInput

//			switch textAreaView.title?.lowercased() {
//			case "ideals":
//				Character.current.flavorText.ideals 		= userInput
//				self.personalityDetailView.idealsCustomText	= userInput
//			case "bonds":
//				Character.current.flavorText.bonds 			= userInput
//				self.personalityDetailView.idealsCustomText	= userInput
//			case "flaws":
//				Character.current.flavorText.flaws 			= userInput
//				self.personalityDetailView.idealsCustomText	= userInput
//			default:
//				break
//			}
		}

		//only allow the user to save if there is text in the field.
		//watch the field with an observer and enable the button when there is text
		saveAction.isEnabled = textField.text != ""

		NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { notification in
			saveAction.isEnabled = textField.text != ""
		}

		//CANCEL ACTION
		let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
		}

		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)

		self.present(alertController, animated: true, completion: nil)
	}
}

extension FlavorViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		//prevent vertical scrolls
		if scrollView.contentOffset.y != 0 {
			scrollView.contentOffset.y = 0 }

		//update the page control
		let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
		pageControl.currentPage = Int(pageIndex)

		//hide keyboard if the page is switched while active
		if let responder = getCurrentResponder() {
			if let responder = responder as? UITextView {
				responder.resignFirstResponder()
			}

			if let responder = responder as? UITextField  {
				responder.resignFirstResponder()
			}
		}
	}
}

extension FlavorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageSelectionDelegate {

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		// Local variable inserted by Swift 4.2 migrator.
		let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

		guard let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage else { print("could not create a proper image"); return }
		basicDetailView.imageSelectionView.imageView.image = pickedImage
		Character.current.flavorText.image	= pickedImage

		dismiss(animated: true, completion: nil)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}

	func selectImage() {
		guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return }

		imagePicker.delegate = self
		imagePicker.sourceType = .savedPhotosAlbum
		imagePicker.allowsEditing = true

		present(imagePicker, animated: true, completion: nil)
	}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

fileprivate extension Selector {
	static let keyboardWillChange = #selector(FlavorViewController.keyboardWillChange(_:))

}
