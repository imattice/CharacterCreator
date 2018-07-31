//
//  ExpandableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/23/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ExpandableViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	var tableViewData = [TableViewData]()

	override func viewDidLoad() {
		super.viewDidLoad()
		getTableViewData()

		registerCells()
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190
	}

}

extension ExpandableViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BackgroundCell", for: indexPath) as! ExpandableTableViewCell
		let data = tableViewData[indexPath.row]

		cell.titleLabel.text 	= data.title.capitalized
		cell.goldLabel.text		= data.gold
		cell.itemsLabel.text	= data.itemString()
		cell.proficiencyLabel.text = data.skillString()
		cell.reputationTitleLabel.text = data.reputationString().title
		cell.reputationLabel.text = data.reputationString().description


		cell.backgroundImageView.image = UIImage(named: data.title.lowercased())

		return cell
	}

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: ExpandableTableViewCell.self),bundle: nil), forCellReuseIdentifier: "BackgroundCell")
	}

	func getTableViewData() {
		for data in backgroundData {
			guard let dataObject = TableViewData(title: data.key) else { print("failed to create data object for \(data.key)"); continue }

			tableViewData.append(dataObject)
		}
	}

	struct TableViewData {
		let title: String
		let gold: String
		private let skills: [String]
//		let description: String
		private let items: [String]
		private let reputation: [String : String]

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
				result += "\(item) "
			}
			return result.replacingLastOccurrenceOfString(",", with: "").trimmingCharacters(in: .whitespaces).capitalized
		}

		func skillString() -> String {
			var result = ""
			for skill in skills {
				result += "+ \(skill)  "
			}
			return result.trimmingCharacters(in: .whitespaces)
		}
	}

}

//MARK: Segue Navigation
extension ExpandableViewController {
	//MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
		let data = tableViewData[selectedIndexPath.section]
		let background = Background(name: data.title)

		Character.current.background = background
		guard let proficiencies = background.proficiencies() else { return }
		Character.current.proficiencies.append(contentsOf: proficiencies)
		
	}

}
