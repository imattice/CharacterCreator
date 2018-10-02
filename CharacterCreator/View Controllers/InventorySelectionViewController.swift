//
//  ChoiceSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ChoiceSelectionViewController: UIViewController {
	@IBOutlet weak var stackView: UIStackView!

	var choiceData = [[Item]]()
	var selections = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

		loadChoiceData()

		for choice in choiceData {
			guard let selectionView = Bundle.main.loadNibNamed("ChoiceSelectionView", owner: self, options: nil)?.first as? ChoiceSelectionView
				else { print("Could not create selectionView"); continue }
				selectionView.choices = choice
				selectionView.backgroundColor = Character.current.class.color().base()

			stackView.addArrangedSubview(selectionView)


			selectionView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint(item: selectionView,
							   attribute: .leading,
							   relatedBy: .equal,
							   toItem: stackView,
							   attribute: .leading,
							   multiplier: 1,
							   constant: 0).isActive = true
			NSLayoutConstraint(item: selectionView,
							   attribute: .trailing,
							   relatedBy: .equal,
							   toItem: stackView,
							   attribute: .trailing,
							   multiplier: 1,
							   constant: 0).isActive = true
			NSLayoutConstraint(item: selectionView,
							   attribute: .height,
							   relatedBy: .equal,
							   toItem: nil,
							   attribute: .height,
							   multiplier: 1,
							   constant: 200).isActive = true
		}

		selections = getSelections()
	}


	func loadChoiceData() {
		guard let classDict = classData[Character.current.class.base] as? [String : Any],
			let classChoices = classDict["equipment"] as? [[String]]  else { print("Could not initialize race equiptment data"); return }

		var choiceOptions = [[Item]]()

		for options in classChoices {
			var choices = [Item]()

			for choice in options {
				let item = Item(choice)
				choices.append(item)
			}

			choiceOptions.append(choices)
		}
		choiceData = choiceOptions
	}

	func getSelections() -> [Item] {
		var result = [Item]()

		for selectionView in stackView.arrangedSubviews {
			guard let selectionView = selectionView as? ChoiceSelectionView else { print("could not cast to Choice Selection View when getting selections"); continue }
			let optionIndex = selectionView.pageControl.currentPage
			let item = selectionView.choices[optionIndex]

			result.append(item)
		}

		return result
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let selectedItems = getSelections()

		Character.current.items = selectedItems
	}

	struct Choice {
		let title: String
		let description: String

	}

}
