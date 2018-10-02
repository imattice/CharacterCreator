//
//  ModalViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//Used to display Spells and Class Features
import UIKit

class ModalTableViewController: UITableViewController {
	@IBOutlet weak var backButton: UIBarButtonItem!

	var tableViewData = [TableViewData]()
	var target: Class?			= Character.default.class  //nil
	var dataType: DataType?		= .ClassFeature				//nil

	

    override func viewDidLoad() {
        super.viewDidLoad()
//		Character.default.class.spellCasting?.spells = [Spell(name: "Acid Splash")!, Spell(name: "Fire Bolt")!, Spell(name: "Charm Person")!, Spell(name: "Magic Missile")!, Spell(name: "Blur")!]

		registerCells()
		getTableData()

		configureNav()

		//enable flexible table view heights
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 190
    }

	@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}

	func configureNav() {
		if let _ = navigationController,
			let dataType = dataType {

			let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonPressed(_:)))
			navigationItem.leftBarButtonItem = backButton

			switch dataType {
			case .ClassFeature: navigationItem.title = "\(target!.path.capitalized) Features"
			case .Spellbook: 	navigationItem.title = "Spellbook"
			}
		}
	}
}

//MARK: TableView Methods
extension ModalTableViewController {


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let dataType = dataType else { print("failed initialize with data type"); return UITableViewCell()}

		if dataType == .ClassFeature {
			//TODO: We should dequeue the cells, but it's tricky to do this and get a .subtitle tableviewcell
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FeatureCell")
			let cellData = tableViewData[indexPath.section].content[indexPath.row] as! ClassFeature

			cell.textLabel?.text 				= cellData.title
			cell.detailTextLabel?.text 			= cellData.description
			cell.detailTextLabel?.numberOfLines = 0

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
		guard Character.default.class.castingAttributes != nil
			else { print("no casting attributes available for \(Character.default.class.base)"); return }

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
				for spell in Character.current.spellBook {
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
	}


	struct TableViewData {
		let level: Int
		var content: [Any]
	}
	enum DataType {
		case ClassFeature, Spellbook
	}


}
