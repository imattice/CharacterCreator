//
//  SpellSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class SpellSelectionViewController: UIViewController, SpellDetailDelegate {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var headerView: SpellSelectionHeaderView!
	var tableViewData = [SpellTableData]()

	var cantripSelectionCount: Int 	{ return Character.default.spellBook.filter( { $0.level == 0 } ).count }
	var spellSelectionCount: Int 	{ return Character.default.spellBook.filter( { $0.level != 0 } ).count }

	let cantripCapacity 	= Character.default.numberOfCantripsKnown()
	let spellbookCapacity	= Character.default.class.castingAttributes!.initialSpellCount

    override func viewDidLoad() {
        super.viewDidLoad()
		registerCells()
		configureNav()
		tableView.allowsMultipleSelection = true

		tableViewData = SpellTableData.getSpellData()

		updateCantripLabel()
		updateSpellLabel()

		tableView.backgroundColor			= Character.default.class.color().darkColor()

		setSelectedSpells()
	}

	private func updateCantripLabel() {
		headerView.cantripCountLabel.text	= "\(cantripSelectionCount) / \(cantripCapacity)"
	}

	private func updateSpellLabel() {
		headerView.spellbookCountLabel.text	= "\(spellSelectionCount) / \(spellbookCapacity)"
	}

	//sets any spells that are already in the spellbook as selected in the tableview
	private func setSelectedSpells() {
		for spell in Character.default.spellBook {
			//create an index path to select in table view
			//get the level for the spell, which will also be the section
			//also grab the index where the names match, which will also be the row
			guard let spellLevelData = tableViewData.filter({ $0.level == spell.level }).first,
				let row = spellLevelData.spells.firstIndex(where: { $0.spell.name == spell.name })
				else { print("Found spell not available in spell data: \(spell.name)"); continue }

			tableView.selectRow(at: IndexPath(row: row, section: spell.level), animated: true, scrollPosition: .none)
		}
	}

//MARK: - SPELL MANAGEMENT

	func addToSpellbook(_ spell: Spell) {
		//check if the spell is already in the book to avoid duplicates
		guard !Character.default.spellBook.contains(where: { $0.name == spell.name })
			else {print("Spellbook already contains \(spell.name)"); return}

		//add the spell to the character spellbook
		Character.default.spellBook.append(spell)

		//update UI
		if spell.level == 0 { updateCantripLabel() }
		else { updateSpellLabel() }
	}
	func removeFromSpellbook(_ spell: Spell) {
		//ensure the spell is in the spellbook before removing it
		guard let index = Character.default.spellBook.firstIndex(where: { $0.name == spell.name })
			else { print("\(spell.name) not in spellbook"); return }

		//remove from character spellbook
		Character.default.spellBook.remove(at: index)

		//update UI
		if spell.level == 0 { updateCantripLabel() }
		else { updateSpellLabel() }
	}
	func didCancelSelection(of spell: Spell) {
		guard let indexPath = index(forSpell: spell) else { return }

		tableView.deselectRow(at: indexPath, animated: false)
	}

	func spellForCell(at indexPath: IndexPath) -> Spell? {
		guard let data = tableViewData.first(where: { $0.level == indexPath.section })
			else { print("could not initialize spell for specified cell at indexPath: \(indexPath.section) \(indexPath.row)"); return nil }

		return data.spells[indexPath.row].spell
	}
	func index(forSpell spell: Spell) -> IndexPath? {
		guard let section = tableViewData.filter({ $0.level == spell.level }).first?.spells,
			let row = section.firstIndex(where: { $0.spell.name == spell.name })
			else { return nil }

		return IndexPath(row: row, section: spell.level)
	}

	func toggleExpansion(forCell cell: SpellTableViewCell, atIndexPath indexPath: IndexPath) {
//		cell.expanded	= !cell.expanded

		tableViewData[indexPath.section].spells[indexPath.row].expanded	= !tableViewData[indexPath.section].spells[indexPath.row].expanded
		tableView.reloadRows(at: [indexPath], with: .automatic)
	}
}

extension SpellSelectionViewController: UITableViewDelegate, UITableViewDataSource {
//CELL CONFIGURAION
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableViewData[indexPath.section].spells.isEmpty { return UITableViewCell() }
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellTableViewCell
		let spellData = tableViewData[indexPath.section].spells[indexPath.row]

//		cell.configure(for: spell)
		cell.configure(for: spellData)

		let backgroundView = UIView()
			backgroundView.backgroundColor 	= Character.default.class.color().base()
		cell.selectedBackgroundView = backgroundView

		return cell
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 { return "Cantrips" }
		return "Level \(tableViewData[section].level) Spells"
	}



//SELECTION EVENTS

	func tableView(_ tableView: UITableView,
				   shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		guard let cell = tableView.cellForRow(at: indexPath),
			let spell = spellForCell(at: indexPath)
			else { print("issue creating cell from selected index path"); return true }

		if spell.isCantrip() && !cell.isSelected {
			guard cantripSelectionCount + 1 <= cantripCapacity else { print("cantrip at limit"); return false }}
		else {
			guard spellSelectionCount + 1 <= spellbookCapacity else { print("spellbook at limit"); return false }}
		return true
	}

	func tableView(_ tableView: UITableView,
				   didSelectRowAt indexPath: IndexPath) {
		guard //let spell = spellForCell(at: indexPath),
			let cell = tableView.cellForRow(at: indexPath) as? SpellTableViewCell
			else { print("no spell for cell at index path section \(indexPath.section) row \(indexPath.row)"); return }
//		addToSpellbook(spell)

//		let spellDetailView = SpellDetailView.view(for: spell)
//		spellDetailView.alpha		= 0
//		spellDetailView.delegate 	= self
//		view.addSubview(spellDetailView)
//		spellDetailView.appear(true)
//		cell.open()
		toggleExpansion(forCell: cell, atIndexPath: indexPath)
//		print("selected: \(cell.expanded)")
	}

	func tableView(_ tableView: UITableView,
				   didDeselectRowAt indexPath: IndexPath) {
		guard let spell = spellForCell(at: indexPath),
			let cell = tableView.cellForRow(at: indexPath) as? SpellTableViewCell
			else { print("no spell for cell at index path section \(indexPath.section) row \(indexPath.row)"); return }

		removeFromSpellbook(spell)

		toggleExpansion(forCell: cell, atIndexPath: indexPath)
	}



//HEADER STICK EVENTS
	//pushing up
	func tableView(_ tableView: UITableView,
				   didEndDisplayingHeaderView view: UIView,
				   forSection section: Int) {

		//lets ensure there are visible rows.  Safety first!
		guard let pathsForVisibleRows = tableView.indexPathsForVisibleRows,
			let firstPath = pathsForVisibleRows.first,
			let lastPath = pathsForVisibleRows.last else { return }

		//compare the section for the header that just disappeared to the section
		//for the bottom-most cell in the table view
		if lastPath.section >= section  && section != tableViewData.count {
			headerView.shiftSlotSlider(toSection: section)
		}

//		//shift the capacity view when cantrips are visible
		let viewingSection = firstPath.section
		if viewingSection == 0 { headerView.highlight(countView: .cantrip)}
		else { headerView.highlight(countView: .spellbook) }

	}

	//pulling down
	func tableView(_ tableView: UITableView,
				   willDisplayHeaderView view: UIView,
				   forSection section: Int) {

		//configure the colors of the headerview
		if let headerView = view as? UITableViewHeaderFooterView {
			headerView.contentView.backgroundColor = Character.default.class.color().darkColor()
			headerView.textLabel?.textColor = .lightGray
		}
		
		//lets ensure there are visible rows.  Safety first!
		guard let pathsForVisibleRows = tableView.indexPathsForVisibleRows,
			let firstPath = pathsForVisibleRows.first else { return }

		//compare the section for the header that just appeared to the section
		//for the top-most cell in the table view
		if firstPath.section == section {
			headerView.shiftSlotSlider(toSection: section - 1)

		}

		//shift the capacity view when cantrips are visible
		let viewingSection = firstPath.section
		if viewingSection == 0 { headerView.highlight(countView: .cantrip)}
		else { headerView.highlight(countView: .spellbook) }
	}

//BORING CONFIG STUFF
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].spells.isEmpty { print("No spells in data.  Spells for section:"); print(tableViewData[section].spells); return 1 }
		return tableViewData[section].spells.count }

	func numberOfSections(in tableView: UITableView) -> Int { return tableViewData.count }

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: SpellTableViewCell.self),bundle: nil), forCellReuseIdentifier: "SpellCell")  }

	struct SpellTableData {
		let level: Int
		var spells: [(expanded: Bool, spell: Spell)]

		//this seems like a clumsy way to handle this.  :/
		static func getSpellData() -> [SpellTableData] {
			var result = [SpellTableData]()
			guard let classDict = classData[Character.default.class.base] as? [String: Any],
				let classSpells = classDict["spells"] as? [String]
				else { return result }

			var spellsByLevel = [  0: [(expanded: Bool, spell: Spell)](),
								   1: [(expanded: Bool, spell: Spell)](),
								   2: [(expanded: Bool, spell: Spell)](),
								   3: [(expanded: Bool, spell: Spell)](),
								   4: [(expanded: Bool, spell: Spell)](),
								   5: [(expanded: Bool, spell: Spell)](),
								   6: [(expanded: Bool, spell: Spell)](),
								   7: [(expanded: Bool, spell: Spell)](),
								   8: [(expanded: Bool, spell: Spell)](),
								   9: [(expanded: Bool, spell: Spell)]()]

			for spellName in classSpells {
				guard let spell = Spell(spellName) else { continue }

				//add the spell to the correct index
				guard var _ = spellsByLevel[spell.level] else { print("could not initialize array from \(spell.level) as a key"); continue }

				spellsByLevel[spell.level]!.append((expanded: false, spell: spell))
			}

			for spells in spellsByLevel {
				if !spells.value.isEmpty {
					result.append(SpellTableData(level: spells.key, spells: spells.value))
				}
			}

			return result.sorted(by: { $0.level < $1.level })
		}
	}
}


// MARK: - Navigation

extension SpellSelectionViewController {
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	private func configureNav() {
		let nextNavItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(navNext))

		navigationItem.rightBarButtonItem = nextNavItem
	}

	@objc func navNext() {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "Background") else { print("could not instatniate result vc"); return }

		navigationController?.pushViewController(vc, animated: true)
	}
}

