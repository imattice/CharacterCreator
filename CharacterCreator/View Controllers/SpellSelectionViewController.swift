//
//  SpellSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class SpellSelectionViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	var targetClass: String {
		if let characterClass = Character.current.class {
			return characterClass.name	}
		else {
			print("defaulted to spells for wizard class")
			return "wizard"} }

	var availableSpellData = [SpellTableData]()

    override func viewDidLoad() {
        super.viewDidLoad()
		registerCells()

		getSpellData()

		tableView.reloadData()
    }

	//this seems like a clumsy way to handle this.  :/
	private func getSpellData() {
		guard let classDict = classData[targetClass] as? [String: Any],
			let classSpells = classDict["spells"] as? [String]
		else { return }

		var spellsByLevel = [  0: [Spell](),
							   1: [Spell](),
							   2: [Spell](),
							   3: [Spell](),
							   4: [Spell](),
							   5: [Spell](),
							   6: [Spell](),
							   7: [Spell](),
							   8: [Spell](),
							   9: [Spell]()]

		for spell in classSpells {
			print("getting info for \(spell)")

			//get the spell info
			guard let targetSpell = spellData[spell] as? [String: Any] else { print("could not find data for \(spell)"); continue }
			let level 		= targetSpell["level"] 			as! String
			let school 		= targetSpell["school"] 		as! String
			let description	= targetSpell["description"] 	as! String
			let castTime 	= targetSpell["cast"] 			as! String
			let range		= targetSpell["range"] 			as! String
			let components	= targetSpell["components"] 	as! String
			let duration	= targetSpell["duration"] 		as! String

			let damage		= targetSpell["damage"] 		as? String


			//create the spell
			let spellFromData = Spell(level: level,
							  name: spell,
							  description: description,
							  school: school,
							  range: range,
							  castTime: castTime,
							  duration: duration,
							  damage: damage,
							  components: components)

			//add the spell to the correct index
			guard let levelIndex = Int(level),
				var spellArray = spellsByLevel[levelIndex] else { print("could not initialize array from \(level) as a key"); continue }
			print("adding \(spellFromData.name) to the \(levelIndex) array")

			spellsByLevel[levelIndex]?.append(spellFromData)
		}

		for spells in spellsByLevel {
			if !spells.value.isEmpty {
				print("adding data for the \(spells.key) level")
				print("are there spells in the array? \(!spells.value.isEmpty) \n How many? \(spells.value.count)")

				availableSpellData.append(SpellTableData(level: spells.key, spells: spells.value))
			}
		}

		availableSpellData.sort(by: { $0.level < $1.level })

		for spells in availableSpellData {
			print(spells.level)
			for spell in spells.spells {
				print(spell.name)
			}
		}
	}




}

extension SpellSelectionViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if availableSpellData[section].spells.isEmpty { print("No!"); print(availableSpellData[section].spells); return 1 }

		return availableSpellData[section].spells.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return availableSpellData.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return String(availableSpellData[section].level)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if availableSpellData[indexPath.section].spells.isEmpty { return UITableViewCell() }
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellTableViewCell
		let spell = availableSpellData[indexPath.section].spells[indexPath.row]//availableSpells[indexPath.row]
		if let damage = spell.damage { 	cell.damageLabel.text			= damage }
		else { 							cell.damageLabel.text			= "-" }

			cell.titleLabel.text 			= spell.name
			cell.componentLabel.text 		= spell.components
			cell.descriptionLabel.text		= spell.description
//			cell.iconView.image		= UIImage(named: spell.name)
			cell.castTimeLabel.text			= spell.castTime
			cell.rangeLabel.text			= spell.range


		return cell
	}

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: SpellTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "SpellCell")
	}

	struct SpellTableData {
		let level: Int
		var spells: [Spell]
	}

}


// MARK: - Navigation

extension SpellSelectionViewController {
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
}

