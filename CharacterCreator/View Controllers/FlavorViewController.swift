//
//  FlavorViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/3/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//


//Social - Name, Age, Alignment, Personality, Height, Build/Weight, Eye Color
//Appearance - clothes, distint markings or features,
//Purpose - Ideals, Bonds, Flaws
//Histroy - Languages, Faction, Backstory


import UIKit

class FlavorViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!

	@IBOutlet weak var historyFlavorView: HistoryFlavorView!
	@IBOutlet weak var driveFlavorView: DriveFlavorView!
	@IBOutlet weak var appearanceFlavorView: AppearanceFlavorView!
	@IBOutlet weak var identityFlavorView: IdentityFlavorView!
	@IBOutlet var flavorViews: [UIView]!

	let imagePicker = UIImagePickerController()

	let colors: [UIColor] = [.red, .yellow, .green, .blue]

	override func viewDidLoad() {
        super.viewDidLoad()
		addViews()

		configureScrollView()

		imagePicker.delegate = self
    }

	private func configureScrollView() {
		scrollView.delegate 						= self
		scrollView.isPagingEnabled 					= true
		scrollView.contentSize 						= CGSize(width: view.frame.width * CGFloat(flavorViews.count),
																height: view.frame.height)
		scrollView.showsHorizontalScrollIndicator	= false
		scrollView.alwaysBounceHorizontal 			= false
		scrollView.isDirectionalLockEnabled 		= true
		scrollView.bounces							= false


		pageControl.numberOfPages 					= flavorViews.count
		pageControl.pageIndicatorTintColor 			= UIColor.lightestShadeForCurrentClass()
		pageControl.currentPageIndicatorTintColor 	= UIColor.colorForCurrentClass()

	}
	private func addViews() {
		for (index, flavorView) in flavorViews.enumerated() {


			flavorView.frame.size.width 	= self.view.frame.size.width
			flavorView.frame.size.height	= self.view.frame.size.height - 90 //subtracting the height of the safe area, the page control and its vertical constraints

			print("view size: \(flavorView.frame.size) /n screen size: \(self.view.frame.size)")
			flavorView.frame.origin.x		= CGFloat(index) * self.view.bounds.size.width

			flavorView.backgroundColor = colors[index]
			scrollView.addSubview(flavorView)
			flavorView.setNeedsDisplay()

		}

	}

	@IBAction func selectImage(_ sender: UITapGestureRecognizer) {
		print("hi!")

		imagePicker.allowsEditing = true
		imagePicker.sourceType = .photoLibrary

		present(imagePicker, animated: true, completion: nil)
	}

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if let nameText =  identityFlavorView.nameField.text { 					Character.current.flavorText.name 	= nameText }
		if let ageText = identityFlavorView.ageField.text { 					Character.current.flavorText.age 	= ageText }
		if let alignmentText = identityFlavorView.alignmentField.text { 		Character.current.flavorText.alignment 	= alignmentText }
		if let personalityText = identityFlavorView.personalityField.text { 	Character.current.flavorText.personality = personalityText}

		if let clothingText = appearanceFlavorView.clothingField.text { 		Character.current.flavorText.clothing = clothingText }
		if let appearanceText = appearanceFlavorView.appearanceField.text { 	Character.current.flavorText.appearance = appearanceText }
		if let characterImage = appearanceFlavorView.imageView.image { 			Character.current.flavorText.image	= characterImage }

		if let idealsText = driveFlavorView.idealsField.text { 					Character.current.flavorText.ideals = idealsText }
		if let bondsText = driveFlavorView.bondsField.text { 					Character.current.flavorText.bonds = bondsText }
		if let flawsText = driveFlavorView.flawsField.text { 					Character.current.flavorText.flaws = flawsText }

		if let languagesText = historyFlavorView.languagesField.text { 			Character.current.languages = [languagesText] }
		if let relationshipsText = historyFlavorView.relationshipsField.text { 	Character.current.flavorText.relationships = relationshipsText }
		if let backstoryText = historyFlavorView.backstoryField.text { 			Character.current.flavorText.backstory = backstoryText }
    }

}

extension FlavorViewController: UITextViewDelegate {

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

extension FlavorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { print("could not create a proper image"); return }
		appearanceFlavorView.imageView.image = pickedImage

		dismiss(animated: true, completion: nil)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
