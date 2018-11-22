//
//  ChoiceSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

//TODO: Would be nice to include an item selection for matial and simple weapons, but I think that would require a data overhaul and a rethink of how this is currently designed.  We would need to display regular items alongside these chosen weapons, as well as the ability to change the labels to reflect he new chosen weapon.  Additionally, we may want to split weapons out from normal items.

class InventorySelectionViewController: UIViewController {
	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var scrollView: UIScrollView!

	var choiceData = [Choice]()

    override func viewDidLoad() {
        super.viewDidLoad()
		loadChoiceData()
		addSelectionViews()

	}

	func loadChoiceData() {
		guard let classDict = classData[Character.default.class.base] as? [String : Any],
			let classChoices = classDict["equipment"] as? [Any]  else { print("Could not initialize class equiptment data"); return } //[Choice]

		var choices = [Choice]()
		for availableChoice in classChoices {
			guard let selectionDict = availableChoice as? [Any] else { print("choice data not stored properly"); return }

			var selections = [Choice.Selection]()
			for availableSelection in selectionDict {
				guard let itemDict = availableSelection as? [String] else { print("Item not contained within array."); return }

				var items = [Item]()
				for itemName in itemDict {

					let item = Item(itemName)

					items.append(item)
				}
				let selection = Choice.Selection(items: items)

				selections.append(selection)
			}

			let choice = Choice(selections: selections)

			choices.append(choice)
		}

		choiceData = choices
	}
	private func addSelectionViews() {
		for choice in choiceData {
			guard let selectionView = Bundle.main.loadNibNamed(String(describing: ChoiceSelectionView.self), owner: self, options: nil)?.first as? ChoiceSelectionView
				else { print("Could not create selectionView"); continue }
			selectionView.delegate = self
			selectionView.choice = choice
			selectionView.backgroundColor = Character.default.class.color().base()

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
		}
	}

	func getSelections() -> [Item] {
		var result = [Item]()

		for selectionView in stackView.arrangedSubviews {
			guard let selectionView = selectionView as? ChoiceSelectionView,
				let selectionViewChoice = selectionView.choice else { print("could not cast to Choice Selection View when getting selections"); continue }
			let optionIndex = selectionView.pageControl.currentPage
			let selection = selectionViewChoice.selections[optionIndex]

			for item in selection.items {
				result.append(item)
			}
		}

		return result
	}

	private func addItemsToCharacter() {
		let selectedItems = getSelections()

		Character.default.items = selectedItems

		for item in Character.default.items {
			print("item added: \(item.name)")

		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		addItemsToCharacter()
	}
}

extension InventorySelectionViewController: SelectionViewDelegate {

	func buttonSelected(forType dataType: ModalTableViewController.DataType) {
		let vc = ModalTableViewController()
		vc.dataType = dataType

		let nav = UINavigationController(rootViewController: vc)
		present(nav, animated: true)
	}

}
