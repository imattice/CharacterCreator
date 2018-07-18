//
//  RaceSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class StatDistributionViewController: UIViewController {
	@IBOutlet weak var strStatView: StatStepperView!
	@IBOutlet weak var conStatView: StatStepperView!
	@IBOutlet weak var dexStatView: StatStepperView!
	@IBOutlet weak var chaStatView: StatStepperView!
	@IBOutlet weak var wisStatView: StatStepperView!
	@IBOutlet weak var intStatView: StatStepperView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		labelViews()
	}

	private func labelViews() {
		strStatView.statTitleLabel.text = "Strength"
		conStatView.statTitleLabel.text = "Constitution"
		dexStatView.statTitleLabel.text = "Dexterity"
		chaStatView.statTitleLabel.text = "Charisma"
		wisStatView.statTitleLabel.text = "Wisdom"
		intStatView.statTitleLabel.text = "Intelligence"
	}

	@IBAction func navigateToNextController(_ sender: UIBarButtonItem) {
		setCharacterStats()

		if let characterClass = Character.current.class,
			let navigationController = navigationController,
			let storyboard = storyboard {

			//if the caster is a spellcaster, push to the Spell Selection Controller
			if characterClass.features[1]!.contains(where: { $0.title == "Spellcasting" }) {
				let vc = storyboard.instantiateViewController(withIdentifier: "SpellSelection")
				vc.title = "\(characterClass.base.capitalized) Spells"

				navigationController.pushViewController(vc, animated: true)						}

			//otherwise move to the inventory selection controller
			else {
				let vc = storyboard.instantiateViewController(withIdentifier: "Result")
				navigationController.pushViewController(vc, animated: true)						}
		}
	}

	private func setCharacterStats() {
		guard let str = Int(strStatView.statValueLabel.text!),
				let con = Int(conStatView.statValueLabel.text!),
				let dex = Int(dexStatView.statValueLabel.text!),
				let cha = Int(chaStatView.statValueLabel.text!),
				let wis = Int(wisStatView.statValueLabel.text!),
				let int = Int(intStatView.statValueLabel.text!) else { return }

		Character.current.stats.str = Character.StatBlock.Stat(value: str)
		Character.current.stats.con = Character.StatBlock.Stat(value: con)
		Character.current.stats.dex = Character.StatBlock.Stat(value: dex)
		Character.current.stats.cha = Character.StatBlock.Stat(value: cha)
		Character.current.stats.wis = Character.StatBlock.Stat(value: wis)
		Character.current.stats.int = Character.StatBlock.Stat(value: int)
	}
}
