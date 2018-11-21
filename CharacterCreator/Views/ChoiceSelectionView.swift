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

	var choice: Choice? {
		didSet {
			config()
			addChoiceViews() } }
	var presentedChoice: String? 	= nil
	var contentHeight: Int? 		= nil

	private func config() {
		guard let choice = choice else { print("choice not set for config"); return }
		scrollView.delegate 						= self
		scrollView.isPagingEnabled 					= true
		scrollView.contentSize 						= CGSize(width: self.bounds.width * CGFloat(choice.selections.count),
																height: 250)
		scrollView.showsHorizontalScrollIndicator 	= false
		scrollView.alwaysBounceHorizontal 			= false
		scrollView.isDirectionalLockEnabled 		= true
		scrollView.bounces							= false

		pageControl.numberOfPages 					= choice.selections.count
		pageControl.hidesForSinglePage				= true
	}

	private func addChoiceViews() {
		guard let choice = choice else { print("choice not set when adding choice views"); return }

		for selection in choice.selections {
			let selectionStack = UIStackView()
				selectionStack.axis 			= .vertical
				selectionStack.distribution 	= .fillEqually
				selectionStack.alignment		= .center
				selectionStack.spacing			= 5
				selectionStack.translatesAutoresizingMaskIntoConstraints = false

			for item in selection.items {
				guard let selectionView = Bundle.main.loadNibNamed(String(describing: SelectionView.self), owner: self, options: nil)?.first as? SelectionView
					else { print("Could not load nib for \(choice)"); continue }

				//configure the choice view
				selectionView.config(for: item)
				selectionView.layer.borderColor = UIColor.black.cgColor
				selectionView.layer.borderWidth = 2.0

				selectionView.translatesAutoresizingMaskIntoConstraints = false
				NSLayoutConstraint(item: selectionView,
								   attribute: .width,
								   relatedBy: .equal,
								   toItem: nil,
								   attribute: .notAnAttribute,
								   multiplier: 1,
								   constant: UIScreen.main.bounds.width).isActive = true

				//add the configured choice view to the vertical stackView
				selectionStack.addArrangedSubview(selectionView)
			}

			stackView.addArrangedSubview(selectionStack)
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

		if choice.name == "martial weapon" || choice.name == "simple weapon" {
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

struct Choice {
	let selections: [Selection]

	struct Selection {
		let items: [Item]
	}
}


