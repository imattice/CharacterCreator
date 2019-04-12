//
//  RaceSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

protocol StatViewDelegate: class {
	func stepperDidChange(_ value: (new: Int, previous: Int?))
}

class StatDistributionViewController: UIViewController, StatViewDelegate {
	@IBOutlet var statViewCollection: [StatStepperView]!
	@IBOutlet var availableStatLabels: [UILabel]!
	@IBOutlet weak var availableStatContainerView: UIView!
	
	let viewTitles = ["Strength", "Constitution", "Dexterity", "Charisma", "Wisdom", "Intelligence" ]

	// controls the animation size of the available stats
	@IBInspectable let minScale: CGFloat = 0.8
	@IBInspectable let maxScale: CGFloat = 1.2

	// repository to track which stats are selected
	var selectedStatValues = [Int]()

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpLabelViews()
		availableStatContainerView.backgroundColor = Character.current.class.color().lightColor()

		//match the max size of the animated stats
		for label in availableStatLabels {
			label.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
		}

		//prevent navigation until stat selection is made
		navigationItem.rightBarButtonItem?.isEnabled = false

		SETSTATSFORTESTING()
	}

	func SETSTATSFORTESTING() {
		var statArray = ["8", "10", "12", "13", "14", "15"]
		selectedStatValues = [8, 10, 12, 13, 14, 15]
		navigationItem.rightBarButtonItem?.isEnabled = true 

		for label in statViewCollection.enumerated() {
			label.element.statValueLabel.text = statArray[label.offset]
		}
	}


	private func setUpLabelViews() {
		for view in statViewCollection.enumerated() {
			view.element.statTitleLabel.text = viewTitles[view.offset]
			view.element.delegate = self
		}
	}
	private func updateLabelViews() {
		//if there is a view that already has this specific number
		for view in statViewCollection {
			//ignore labels with a "-"
			guard let viewValue = Int(view.statValueLabel.text!) else { continue }

			//color the labels
			if selectedStatValues.hasDuplicate(viewValue) {
				view.statValueLabel.textColor = .gray								}
			else {
				view.statValueLabel.textColor = Character.current.class.color().base()		}
		}
	}

	private func updateAvailableStats(_ value: (new: Int, previous: Int?)) {
		//add the new value
		selectedStatValues.append(value.new)

		//remove the previous
		if let previousValue = value.previous,
			let indexOfPrevious = selectedStatValues.firstIndex(where: { $0 == previousValue }) {
			selectedStatValues.remove(at: indexOfPrevious)
		}

		//update the status of the available stats
		for label in availableStatLabels {
				if selectedStatValues.contains(Int(label.text!)!) {
					UIView.animate(withDuration: 0.25) {
						label.transform = CGAffineTransform(scaleX: self.minScale, y: self.minScale)
						label.textColor = .gray
					} }
				else {
					UIView.animate(withDuration: 0.5) {
						label.transform = CGAffineTransform(scaleX: self.maxScale, y: self.maxScale)
						label.textColor = .black
					} }
		}
	}

	func stepperDidChange(_ value: (new: Int, previous: Int?)) {
		updateAvailableStats(value)
		updateLabelViews()

		if selectedStatValues.count == 6 && !selectedStatValues.hasDuplicates() {
			navigationItem.rightBarButtonItem?.isEnabled = true					}
		else {
			navigationItem.rightBarButtonItem?.isEnabled = false				}
	}

	@IBAction func navigateToNextController(_ sender: UIBarButtonItem) {
		setCharacterStats()

		if let navigationController = navigationController,
			let storyboard = storyboard,
			let characterClass = Character.current.class {


			//if the caster is a spellcaster, push to the Spell Selection Controller
			if characterClass.castingAttributes != nil {
				let vc = storyboard.instantiateViewController(withIdentifier: "SpellSelection")
				vc.title = "\(characterClass.base.capitalized) Spells"

				navigationController.pushViewController(vc, animated: true)						}

			//otherwise move to the inventory selection controller
			else {
				let vc = storyboard.instantiateViewController(withIdentifier: "Background")
				navigationController.pushViewController(vc, animated: true)						}
		}
	}

	private func setCharacterStats() {
		for view in statViewCollection {
			guard let valueString = view.statValueLabel.text,
				let titleString = view.statTitleLabel.text,
				let value = Int(valueString),
				let stat = StatType(fromLonghand: titleString) else { print("could not initilialize the stat data from the view."); continue }

				switch stat {
				case .str: 		Character.current.stats.str = Character.StatBlock.Stat(value: value)
				case .con:		Character.current.stats.con = Character.StatBlock.Stat(value: value)
				case .cha:		Character.current.stats.cha = Character.StatBlock.Stat(value: value)
				case .dex:		Character.current.stats.dex = Character.StatBlock.Stat(value: value)
				case .wis:		Character.current.stats.wis = Character.StatBlock.Stat(value: value)
				case .int:		Character.current.stats.int = Character.StatBlock.Stat(value: value)
				}
		}
	}

//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		setCharacterStats()
//
//		if segue.identifier == "toBackgroundSelection" {
//
//		if let characterClass = Character.current.class,
//			let navigationController = navigationController,
//			let storyboard = storyboard {
//
//
//			//if the caster is a spellcaster, push to the Spell Selection Controller
//			if characterClass.castingAbility != nil {
//				let vc = storyboard.instantiateViewController(withIdentifier: "SpellSelection")
//				vc.title = "\(characterClass.base.capitalized) Spells"
//
//
//				segue.destination = vc															}
//
//			//otherwise move to the inventory selection controller
//			else {
//				performSegue
//				let vc = storyboard.instantiateViewController(withIdentifier: "Background")
//
//
//				navigationController.pushViewController(vc, animated: true)						}
//		}
//		}
//	}

}


