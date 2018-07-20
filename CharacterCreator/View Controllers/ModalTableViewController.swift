//
//  ModalViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ModalTableViewController: UITableViewController {
	@IBOutlet weak var backButton: UIBarButtonItem!

	var tableViewData = [TableViewData]()
	var target: Class?			= Character.default.class!  //nil
	var dataType: DataType?		= .Spellbook				//nil

    override func viewDidLoad() {
        super.viewDidLoad()
		Character.default.spellBook = [Spell(name: "Acid Splash")!, Spell(name: "Fire Bolt")!, Spell(name: "Charm Person")!, Spell(name: "Magic Missile")!, Spell(name: "Blur")!]

		registerCells()
		getTableData()


		//enable flexible table view heights
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190
    }

	@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
}

//MARK: TableView Methods
extension ModalTableViewController {


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let dataType = dataType else { print("failed initialize with data type"); return UITableViewCell()}

		if dataType == .ClassFeature {
			let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell", for: indexPath)
			let cellData = tableViewData[indexPath.section].content[indexPath.row] as! ClassFeature

			cell.textLabel?.text 		= cellData.title
			cell.detailTextLabel?.text 	= cellData.description

			return cell
		}
		if dataType == .Spellbook {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellTableViewCell
			let spell = tableViewData[indexPath.section].content[indexPath.row] as! Spell

			cell.configure(for: spell)

			return cell
		}

		return UITableViewCell()
	}
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let dataType = dataType else { print("failed to initialize header title with data type"); return nil }
		var result = ""
		switch dataType {
		case .ClassFeature: result  = "Level \(tableViewData[section].level)"
		case .Spellbook: result 		= "Spell Level \(tableViewData[section].level)"
		}

		return result
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if !tableViewData[section].content.isEmpty { return tableViewData[section].content.count  }
		else { return 1 }
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	private func getTableData() {
		if dataType == .ClassFeature {
			//fill the tableviewdatasource with delicious content
			guard let target = target else {print("No class set"); return }
			let features = target.getAllLevelFeatures()

			for feature in features {
				tableViewData.append(TableViewData(level: feature.key, content: feature.value) )
			}
		}

		if dataType == .Spellbook {
			for level in 0...Spell.maxLevel {
				var spells = [Spell]()
				for spell in Character.default.spellBook {
					if spell.level == String(level) { spells.append(spell)}
				}
				if !spells.isEmpty {
					let data = TableViewData(level: level, content: spells)
					tableViewData.append(data)
				}
			}
		}

		tableViewData.sort(by: { $0.level < $1.level })
	}

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: SpellTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "SpellCell")
//		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FeatureCell")
	}


	struct TableViewData {
		let level: Int
		var content: [Any]
	}
	enum DataType {
		case ClassFeature, Spellbook
	}


}
