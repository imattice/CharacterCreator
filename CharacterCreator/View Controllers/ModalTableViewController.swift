//
//  ModalViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//Used to display Spells and Class Features
import UIKit

protocol ItemSelectionDelegate {
	
}

class ModalTableViewController: UITableViewController {
	@IBOutlet weak var backButton: UIBarButtonItem!

	var tableViewData = [TableViewData]()
	var target: Class?			= Character.current.class  //nil
	var dataType: DataType?		= .ClassFeature				//nil
	

    override func viewDidLoad() {
        super.viewDidLoad()

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
	@objc func confirmationButtonPressed(_ sender: UIBarButtonItem) {

		self.dismiss(animated: true, completion: nil)
	}

	func configureNav() {
		if let _ = navigationController,
			let dataType = dataType {

			let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonPressed(_:)))
			navigationItem.leftBarButtonItem = backButton

			if dataType == .ItemSelectionMartial || dataType == .ItemSelectionSimple {
				let confirmButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: #selector(confirmationButtonPressed(_:)))
				navigationItem.rightBarButtonItem = confirmButton
			}

			switch dataType {
			case .ClassFeature: 		navigationItem.title 	= "\(target!.path.capitalized) Features"
			case .Spellbook: 			navigationItem.title 	= "Spellbook"
			case .ItemSelectionMartial: navigationItem.title 	= "Martial Weapons"
			case .ItemSelectionSimple:	navigationItem.title	= "Simple Weapons"
			}
		}
	}
}

//MARK: TableView Methods
extension ModalTableViewController {


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let dataType = dataType else { print("failed initialize with data type"); return UITableViewCell()}

		switch dataType {
		case .ClassFeature:
			//TODO: We should dequeue the cells, but it's tricky to do this and get a .subtitle tableviewcell
			let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FeatureCell")
			let cellData = tableViewData[indexPath.section].content[indexPath.row] as! ClassFeature

			cell.textLabel?.text 				= cellData.title
			cell.detailTextLabel?.text 			= cellData.description
			cell.detailTextLabel?.numberOfLines = 0

			return cell

		case .Spellbook:
			let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellTableViewCell
			let spell = tableViewData[indexPath.section].content[indexPath.row] as! Spell

			cell.configure(for: spell)

			return cell
		case .ItemSelectionMartial, .ItemSelectionSimple:
			let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSelectionCell", for: indexPath) as! ItemSelectionTableViewCell
			let item = tableViewData[indexPath.section].content[indexPath.row] as! Item

			cell.configure(for: item)

			return cell
		}

	}
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let dataType = dataType else { print("failed to initialize header title with data type"); return nil }

		switch dataType {
		case .ClassFeature: 								return "Level \(tableViewData[section].level)"
		case .Spellbook: 									return "Spell Level \(tableViewData[section].level)"
		case .ItemSelectionMartial, .ItemSelectionSimple: 	return ""
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if !tableViewData[section].content.isEmpty { return tableViewData[section].content.count  }
		else { return 1 }
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	private func getTableData() {
		guard let dataType = dataType else { print("failed to initialize table data with data type"); return }

		switch dataType {
		case .ClassFeature:
			//fill the tableviewdatasource with delicious content
			guard let target = target else {print("No class set"); return }
			let features = target.getAllLevelFeatures()

			for feature in features {
				tableViewData.append(TableViewData(level: feature.key, content: feature.value) )
			}


		case .Spellbook:
			guard Character.current.class.castingAttributes != nil
				else { print("no casting attributes available for \(Character.current.class.base)"); return }
			for level in 0...Spell.maxLevel {
				var spells = [Spell]()
				for spell in Character.current.spellBook {
					if spell.level == level { spells.append(spell)}
				}
				if !spells.isEmpty {
					let data = TableViewData(level: level, content: spells)
					tableViewData.append(data)
				}
			}


		case .ItemSelectionMartial, .ItemSelectionSimple:
			var dataSource: [String] {
				switch dataType {
				case .ItemSelectionMartial:	return MartialWeapons
				case .ItemSelectionSimple: 	return SimpleWeapons

				default:					return [String]()	} }

			var result = [Item]()
			for string in dataSource {
				let item = Item(string)
				result.append(item)
			}

			let data = TableViewData(level: 0, content: result)
			tableViewData.append(data)
		}

		tableViewData.sort(by: { $0.level < $1.level })
	}

	private func registerCells() {
		guard let dataType = dataType else { print("failed to initialize tableViewCells with data type"); return }

		switch dataType {
		case .Spellbook:
			tableView.register(UINib(nibName: String(describing: SpellTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "SpellCell")
		case .ItemSelectionMartial, .ItemSelectionSimple:
			tableView.register(UINib(nibName: String(describing: ItemSelectionTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "ItemSelectionCell")
		default:	return
		}
	}


	struct TableViewData {
		let level: Int
		var content: [Any]
	}
	enum DataType {
		case ClassFeature, Spellbook, ItemSelectionMartial, ItemSelectionSimple
	}


}
