//
//  ExpandableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/23/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class BackgroundSelectionViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	var tableViewData = [TableViewData]()

	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewData = loadTableData()

		registerCells()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 190

		navigationItem.rightBarButtonItem?.isEnabled = false
	}


	private func toggleCellExpansion(at indexPath: IndexPath) {
		tableViewData[indexPath.row].expanded = !tableViewData[indexPath.row].expanded
		tableView.reloadRows(at: [indexPath], with: .automatic)
	}
}

extension BackgroundSelectionViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let selectedPaths = tableView.indexPathsForSelectedRows {
			if !selectedPaths.isEmpty {
				navigationItem.rightBarButtonItem?.isEnabled = true  }
			else {
				navigationItem.rightBarButtonItem?.isEnabled = false }
		}

		toggleCellExpansion(at: indexPath)
		tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
	}

	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		toggleCellExpansion(at: indexPath)
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BackgroundCell", for: indexPath) as! BackgroundSelectionTableViewCell
		let data = tableViewData[indexPath.row]

		cell.configure(data)
		return cell
	}

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: BackgroundSelectionTableViewCell.self),bundle: nil), forCellReuseIdentifier: "BackgroundCell")
	}

	private func loadTableData() -> [TableViewData] {
		var result = [TableViewData]()
		for data in backgroundData {
			guard let dataObject = TableViewData(title: data.key) else { print("failed to create data object for \(data.key)"); continue }

			result.append(dataObject)
		}

		return result.sorted(by: { $0.title < $1.title })
	}

	struct TableViewData {
		let title: String
		let gold: String
		private let skills: [String]
		private let items: [String]
		private let reputation: [String : String]

		var expanded: Bool = false

		init?(title: String) {
			guard let backgroundDict = backgroundData[title.lowercased()] as? [String : Any]
				else { print("could not create background from \(title)"); return nil }
			guard let gold = backgroundDict["coin"] as? String 							else {print("no coin"); return nil}
			guard let skills = backgroundDict["skills"] as? [String] 					else {print("no skills"); return nil}
			guard let items = backgroundDict["equipment"] as? [String] 					else {print("no items"); return nil}
			guard let reputation = backgroundDict["reputation"] as? [String : String] 	else {print("no rep"); return nil}

			self.title 				= title
			self.gold 				= gold
			self.skills 			= skills
			self.items 				= items
			self.reputation 		= reputation
		}

		func reputationString() -> (title: String, description: String) {
			var title: String		= ""
			var description: String = ""
			for rep in reputation {
				title = rep.key
				description = rep.value
			}
			return (title: title, description: description)
		}

		func itemString() -> String {
			var result = ""
			for item in items {
				result += "• \(item.capitalized) \n"
			}
			return result.replacingLastOccurrenceOfString(",", with: "").trimmingCharacters(in: .whitespaces).capitalized
		}

		func skillString() -> String {
			var result = ""
			for skill in skills {
				result += "• \(skill.capitalized)  "
			}
			result += "•"
			return result
		}
	}

}

//MARK: Segue Navigation
extension BackgroundSelectionViewController {
	//MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
		let data = tableViewData[selectedIndexPath.section]
		let background = Background(data.title)

		Character.current.background = background
		guard let proficiencies = background.proficiencies() else { return }
		Character.current.proficiencies.append(contentsOf: proficiencies)
		
	}
}
