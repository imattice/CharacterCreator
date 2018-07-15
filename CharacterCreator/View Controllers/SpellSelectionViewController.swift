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
	@IBOutlet weak var headerView: SpellSelectionHeaderView!
	
	var targetClass: String {
		if let characterClass = Character.current.class {
			return characterClass.base	}
		else {
			print("defaulted to spells for wizard class")
			return "wizard"} }

	var tableViewData = [SpellTableData]()

    override func viewDidLoad() {
        super.viewDidLoad()
		registerCells()

		getSpellData()
		paint()

//		tableView.reloadData()
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

		for spellName in classSpells {
			guard let spell = Spell(name: spellName) else { continue }

			//add the spell to the correct index
			guard let levelIndex = Int(spell.level),
				var _ = spellsByLevel[levelIndex] else { print("could not initialize array from \(spell.level) as a key"); continue }

			spellsByLevel[levelIndex]!.append(spell)
		}

		for spells in spellsByLevel {
			if !spells.value.isEmpty {
				tableViewData.append(SpellTableData(level: spells.key, spells: spells.value))
			}
		}

		tableViewData.sort(by: { $0.level < $1.level })
	}

	//pushing up
	func tableView(_ tableView: UITableView,
				   didEndDisplayingHeaderView view: UIView,
				   forSection section: Int) {

		//lets ensure there are visible rows.  Safety first!
		guard let pathsForVisibleRows = tableView.indexPathsForVisibleRows,
			let lastPath = pathsForVisibleRows.last else { return }

		//compare the section for the header that just disappeared to the section
		//for the bottom-most cell in the table view
		if lastPath.section >= section  && section != tableViewData.count {
			headerView.shiftSlider(toSection: section + 1)
		}

	}

	//pulling down
	func tableView(_ tableView: UITableView,
				   willDisplayHeaderView view: UIView,
				   forSection section: Int) {

		//lets ensure there are visible rows.  Safety first!
		guard let pathsForVisibleRows = tableView.indexPathsForVisibleRows,
			let firstPath = pathsForVisibleRows.first else { return }

		//compare the section for the header that just appeared to the section
		//for the top-most cell in the table view
		if firstPath.section == section {
			headerView.shiftSlider(toSection: section)
		}
	}



}

extension SpellSelectionViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableViewData[indexPath.section].spells.isEmpty { return UITableViewCell() }
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellTableViewCell
		let spell = tableViewData[indexPath.section].spells[indexPath.row]//availableSpells[indexPath.row]
		if let damage = spell.damage { 	cell.damageLabel.text			= "💥:\(damage)" }
		else { 							cell.damageLabel.text			= "" }

			cell.titleLabel.text 			= spell.name
			cell.descriptionLabel.text		= spell.description()
			cell.iconView.image				= UIImage(named: spell.school)

			cell.rangeLabel.text			= "🏹: \(spell.range)"


		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 { return "Cantrips" }
		return "Level \(tableViewData[section].level) Spells"
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].spells.isEmpty { print("No!"); print(tableViewData[section].spells); return 1 }

		return tableViewData[section].spells.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
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

extension SpellSelectionViewController: Paintable {
	func paint() {
		headerView.sliderView.backgroundColor 	= UIColor.paintColor()
		self.view.backgroundColor				= UIColor.paintColor()
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))

		print("painting the headers")
		headerView.tintColor = UIColor.paintColor()

		return headerView
	}
}

