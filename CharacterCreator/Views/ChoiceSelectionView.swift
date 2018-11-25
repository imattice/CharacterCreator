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
	var delegate: SelectionViewDelegate?

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

			let selectionItems = selection.items

			for item in selection.items {
				guard let selectionView = Bundle.main.loadNibNamed(String(describing: SelectionView.self), owner: self, options: nil)?.first as? SelectionView
					else { print("Could not load nib for \(choice)"); continue }

				//check for multiple iterations of the same item
				let itemFrequency = selectionItems.filter({ item.name == $0.name }).count

				if itemFrequency > 1 {
					selectionView.config(forMultiple: itemFrequency, items: item)		}
				else {
					selectionView.config(for: item)									}

				//configure the choice view
				selectionView.delegate = delegate
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

				//prevent further views added to this selection if multiple items were detected
				if itemFrequency > 1 { break }
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

protocol SelectionViewDelegate {
	func buttonSelected(forView view: SelectionView)
}

class SelectionView: UIView {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var button: UIButton!

	var weaponType: WeaponType?
	var delegate: SelectionViewDelegate?

	func config(for choice: Item) {
		self.layoutIfNeeded()

		titleLabel.text 			= choice.name.capitalized
		descriptionLabel.text 		= choice.description()
		imageView.image 			= choice.image()
		backgroundColor				= UIColor.lightGray

		//determine if the item is a weapon and set its type
		if choice.name == "martial weapon" 		{
			weaponType = .martial				}
		else if choice.name == "simple weapon" 	{
			weaponType = .simple 				}
		else 									{
			weaponType = nil					}

		//remove the buttoon unless there's a choice to be made
		if weaponType == .simple || weaponType == .martial {
			configureButton(for: choice)					}
		else {
			button.setTitle("", for: .normal)				}

		descriptionLabel.sizeToFit()
	}

	func config(forMultiple count: Int, items item: Item) {
		config(for: item)
		titleLabel.text = "\(count) \(item.name)s".capitalized
	}

	func update(withItem item: Item) {
		titleLabel.text 			= item.name.capitalized
		descriptionLabel.text 		= item.description()
		imageView.image 			= item.image()

		button.setTitle("Change Weapon", for: .normal)
	}

	private func configureButton(for choice: Item) {
		let buttonTitle = "Select Weapon"

		button.setTitle(buttonTitle, for: .normal)
	}

	@IBAction func buttonSelected(_ sender: UIButton) {
		//ensure there is a weapon type.  The button shouldn't be available if there isn't, but it's probably good to check anyway
		guard let _ = weaponType else { print("weaponType not set"); return }

		delegate?.buttonSelected(forView: self)
	}
}

struct Choice {
	let selections: [Selection]

	struct Selection {
		let items: [Item]
	}
}
enum WeaponType {
	case simple, martial }


