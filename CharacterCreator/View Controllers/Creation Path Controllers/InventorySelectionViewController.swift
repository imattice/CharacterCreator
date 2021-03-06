//
//  ChoiceSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class InventorySelectionViewController: UIViewController {
	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var scrollView: UIScrollView!

	var choiceData = [Choice]()

    override func viewDidLoad() {
        super.viewDidLoad()
		loadChoiceData()
		addSelectionViews()

		addItemsToCharacter()
	}

	func loadChoiceData() {
		guard let classDict = classData[Character.current.class.base] as? [String : Any],
			let classChoices = classDict["equipment"] as? [Any]  else { print("Could not initialize class equiptment data"); return } //[Choice]

		//add choices
		var choices = [Choice]()
		for availableChoice in classChoices {
			guard let selectionDict = availableChoice as? [Any] else { print("choice data not stored properly"); return }

			//add selections to the choice
			var selections = [Choice.Selection]()
			for availableSelection in selectionDict {
				guard let itemDict = availableSelection as? [String] else { print("Item not contained within array."); return }

				//add items to the selection
				var items = [Item]()
				for itemName in itemDict {
					if itemName == "simple weapon" || itemName == "martial weapon" {
						items.append(WeaponSelectionItem(itemName))
						continue													}
					if let weapon = WeaponRecord.record(for: itemName)?.weapon() {
						items.append(weapon)
						continue													}
					if let armor = ArmorRecord.record(for: itemName)?.armor() {
						items.append(armor)
						continue													}
					if let pack = PackRecord.record(for: itemName)?.pack() {
						items.append(pack)
						continue													}

					 if let item = ItemRecord.record(for: itemName)?.item() {
						items.append(item)
						continue													}
					else {
						items.append(Item(itemName, type: .other))
					}
				}

				let selection = Choice.Selection(items: items)
				selections.append(selection)
			}

			let choice = Choice(selections: selections)
			choices.append(choice)
		}

		//set the choice data to the
		choiceData = choices


	}
	private func addSelectionViews() {
		for choice in choiceData {
			guard let selectionView = Bundle.main.loadNibNamed(String(describing: ChoiceSelectionView.self), owner: self, options: nil)?.first as? ChoiceSelectionView
				else { print("Could not create selectionView"); continue }
			selectionView.delegate = self
			selectionView.choice = choice
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
		}
	}

	private func getSelections() -> [Item] {
		var result = [Item]()

		for choiceView in stackView.arrangedSubviews {
			guard let choiceView = choiceView as? ChoiceSelectionView
				else { print("could not cast to Choice Selection View when getting selections"); continue }
			guard let stackView = choiceView.stackView.arrangedSubviews[choiceView.pageControl.currentPage] as? UIStackView,
				let selectionViews = stackView.arrangedSubviews as? [SelectionView]
				else { print("Could not get selection views from Choice View"); continue }

			for selectionView in selectionViews {
				guard let text = selectionView.titleLabel.text else { print("title text unavailable"); continue}

				if let weapon = WeaponRecord.record(for: text)?.weapon() {
					result.append(weapon)
					continue												}
				if let armor = ArmorRecord.record(for: text)?.armor() {
					result.append(armor)
					continue												}
				if let pack = PackRecord.record(for: text)?.pack() {
					result.append(pack)
					continue												}
				if let item = ItemRecord.record(for: text)?.item() {
					result.append(item)
					continue												}
				else {
					let item = Item(text, type: .other)
					result.append(item)										}
			}
		}

		return result
	}

	private func addItemsToCharacter() {
		let selectedItems = getSelections()

		Character.current.items = selectedItems

		print(Character.current.items)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		addItemsToCharacter()
	}
}

extension InventorySelectionViewController: SelectionViewDelegate {
	func buttonSelected(forView view: SelectionView) {
		guard let weaponType = view.weaponType else { print("weapon type not set when weapon selection button pressed"); return }
		if weaponType == .none { return }

		let vc = WeaponSelectionTableViewController()
		vc.weaponType = weaponType
		vc.selectionView = view

		let nav = UINavigationController(rootViewController: vc)
		present(nav, animated: true)
	}
}
