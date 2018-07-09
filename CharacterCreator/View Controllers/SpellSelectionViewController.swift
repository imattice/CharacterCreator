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

	var targetClass: String = "wizard" //Character.current.class?.name
	var availableSpells: [Spell] = [Spell]()

    override func viewDidLoad() {
        super.viewDidLoad()
		registerCells()

		getSpellData(forClass: targetClass)

		tableView.reloadData()
    }

	private func getSpellData(forClass targetClass: String) {
		guard let classDict = classData[targetClass] as? [String: Any],
			let classSpells = classDict["spells"] as? [String]
		else { return }

		for spell in classSpells {
			//get the spell info
			guard let targetSpell = spellData[spell] as? [String: Any] else {print("could not find data for \(spell)"); return }

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

			//add the spell to the array
			availableSpells.append(spellFromData)
		}
	}




}

extension SpellSelectionViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if availableSpells.isEmpty {print("No!"); print(availableSpells); return 1 }

		return availableSpells.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellTableViewCell
		let spell = availableSpells[indexPath.row]
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

}


// MARK: - Navigation

extension SpellSelectionViewController {
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
}

