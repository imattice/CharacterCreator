//
//  ChoiceContainerView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ChoiceSelectionView: UIView {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var stackView: UIStackView!

	var choices = [Item]() {
		didSet {
			config()
			addChoiceViews() } }
	var presentedChoice: String? 	= nil
	var contentHeight: Int? 		= nil

	private func config() {
		scrollView.delegate 						= self
		scrollView.isPagingEnabled 					= true
		scrollView.contentSize 						= CGSize(width: self.bounds.width * CGFloat(choices.count),
																height: 250)
		scrollView.showsHorizontalScrollIndicator 	= false
		scrollView.alwaysBounceHorizontal 			= false
		scrollView.isDirectionalLockEnabled 		= true
		scrollView.bounces							= false

		pageControl.numberOfPages 					= choices.count
		pageControl.hidesForSinglePage				= true
	}

	private func addChoiceViews() {

		for (index, choice) in choices.enumerated() {
			let selectionStack = UIStackView()
				selectionStack.axis 			= .vertical
				selectionStack.distribution 	= .fillEqually
				selectionStack.alignment		= .fill
				selectionStack.spacing			= 10
				selectionStack.translatesAutoresizingMaskIntoConstraints = false

			guard let choiceView = Bundle.main.loadNibNamed(String(describing: SelectionView.self), owner: self, options: nil)?.first as? SelectionView
				else { print("Could not load nib for \(choice)"); continue }

			//configure the choice view
			choiceView.config(for: choice)
			choiceView.layer.borderColor = UIColor.blue.cgColor
			choiceView.layer.borderWidth = 5.0

			choiceView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint(item: choiceView,
							   attribute: .width,
							   relatedBy: .equal,
							   toItem: nil,
							   attribute: .notAnAttribute,
							   multiplier: 1,
							   constant: UIScreen.main.bounds.width).isActive = true


//			scrollView.addSubview(choiceView)

//			choiceView.frame.size.width 	= self.bounds.size.width


//			choiceView.frame.origin.x 		= CGFloat(index) * self.bounds.size.width

			//add all selections to this choice view
//			selectionStack.frame.size.width 	= self.bounds.size.width
//			selectionStack.frame.origin.x 		= CGFloat(index) * self.bounds.size.width

//			selectionStack.addArrangedSubview(choiceView)
			stackView.addArrangedSubview(choiceView)

//			scrollView.addSubview(selectionStack)
//
//			selectionStack.translatesAutoresizingMaskIntoConstraints = false
//			NSLayoutConstraint(item: selectionStack,
//							   attribute: .top,
//							   relatedBy: .equal,
//							   toItem: stackView,
//							   attribute: .top,
//							   multiplier: 1,
//							   constant: 0).isActive = true
//			NSLayoutConstraint(item: selectionStack,
//							   attribute: .bottom,
//							   relatedBy: .equal,
//							   toItem: stackView,
//							   attribute: .top,
//							   multiplier: 1,
//							   constant: 0).isActive = true
//			NSLayoutConstraint(item: selectionStack,
//							   attribute: .width,
//							   relatedBy: .equal,
//							   toItem: nil,
//							   attribute: .notAnAttribute,
//							   multiplier: 1,
//							   constant: UIScreen.main.bounds.width).isActive = true
//			NSLayoutConstraint(item: selectionStack,
//							   attribute: .height,
//							   relatedBy: .equal,
//							   toItem: nil,
//							   attribute: .notAnAttribute,
//							   multiplier: 1,
//							   constant: 400).isActive = true
//			NSLayoutConstraint(item: selectionStack,
//							   attribute: .leading,
//							   relatedBy: .equal,
//							   toItem: self,
//							   attribute: .leading,
//							   multiplier: 1,
//							   constant: CGFloat(index) * self.bounds.size.width).isActive = true

		}
	}
}

extension ChoiceSelectionView: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		//prevent vertical scrolls
		if scrollView.contentOffset.y != 0 {
			scrollView.contentOffset.y = 0 }

		let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
		pageControl.currentPage = Int(pageIndex)
	}
}


class SelectionView: UIView {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var button: UIButton!

	func config(for choice: Item) {
		self.layoutIfNeeded()

		titleLabel.text 			= choice.name.capitalized
		descriptionLabel.text 		= choice.description()
		imageView.image 			= choice.image()
		backgroundColor				= UIColor.lightGray

		if choice.name == "quarterstaff" {
			configureButton(for: choice)					}
		else {
			button.removeFromSuperview()		}

		descriptionLabel.sizeToFit()


	}

	private func configureButton(for choice: Item) {
		let buttonTitle = "Select Weapon"

		button.setTitle(buttonTitle, for: .normal)
	}
	@IBAction func buttonSelected(_ sender: UIButton) {

	}

	private func updateConfig(for item: Item) {

	}
}

struct Selection {
	let title: String
	let description: String
	let damage: String?


	func toItem() -> Item {

		return Item("test")
	}
}



//Can display the item data for any item
//Can handle multiple subchoices
//Can rewrite data with a specific weapon

