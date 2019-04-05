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

	let imagePicker = UIImagePickerController()

	let colors: [UIColor] = [.red, .yellow, .green, .blue]

	override func viewDidLoad() {
        super.viewDidLoad()

		configureViews()

		configureScrollView()

		basicDetailView.imageSelectionDelegate = self

//		let textFieldView = TextFieldView()
//		textFieldView.config()
//		textFieldView.backgroundColor = .lightGray
//		scrollView.addSubview(textFieldView)

//		imagePicker.delegate = self
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


//
//			print("flavorView width: \(flavorView.frame.size.width)")
//			print("self width: \(view.frame.size.width)")
//
//			if let flavorView = flavorView as? BasicDetailView {
//				flavorView.textViewDelegate 		= self
//				flavorView.textFieldDelegate 		= self
//				flavorView.imagePickerDelegate 		= self
//			}
//
		}
	}






    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//		if let nameText =  identityFlavorView.nameField.text { 					Character.default.flavorText.name 	= nameText }
//		if let ageText = identityFlavorView.ageField.text { 					Character.default.flavorText.age 	= ageText }
//		if let alignmentText = identityFlavorView.alignmentField.text { 		Character.default.flavorText.alignment 	= alignmentText }
//		if let personalityText = identityFlavorView.personalityField.text { 	Character.default.flavorText.personality = personalityText}
//
//		if let clothingText = appearanceFlavorView.clothingField.text { 		Character.default.flavorText.clothing = clothingText }
//		if let appearanceText = appearanceFlavorView.appearanceField.text { 	Character.default.flavorText.appearance = appearanceText }
//		if let characterImage = appearanceFlavorView.imageView.image { 			Character.default.flavorText.image	= characterImage }
//
//		if let idealsText = driveFlavorView.idealsField.text { 					Character.default.flavorText.ideals = idealsText }
//		if let bondsText = driveFlavorView.bondsField.text { 					Character.default.flavorText.bonds = bondsText }
//		if let flawsText = driveFlavorView.flawsField.text { 					Character.default.flavorText.flaws = flawsText }
//
//		if let languagesText = historyFlavorView.languagesField.text { 			Character.default.languages = [languagesText] }
//		if let relationshipsText = historyFlavorView.relationshipsField.text { 	Character.default.flavorText.relationships = relationshipsText }
//		if let backstoryText = historyFlavorView.backstoryField.text { 			Character.default.flavorText.backstory = backstoryText }
//    }

}

extension FlavorViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		//prevent vertical scrolls
		if scrollView.contentOffset.y != 0 {
			scrollView.contentOffset.y = 0 }

		let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
		pageControl.currentPage = Int(pageIndex)
	}
}

//extension FlavorViewController: UITextFieldDelegate {
//	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//		print("hi")
//		return true
//	}
//
//	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//		print("hi")
//		return true
//	}
//}
//
//extension FlavorViewController: UITextViewDelegate {
//
//}
//
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
