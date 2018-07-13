//
//  ClassDetailViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ClassDetailTableViewController: UITableViewController {
	@IBOutlet weak var backButton: UIBarButtonItem!

	var tableViewData = [TableViewData]()
	var target: Class?			= nil

    override func viewDidLoad() {
        super.viewDidLoad()

		//fill the tableviewdatasource with delicious content
		guard let target = target else {print("No class set"); return }
		let features = target.getAllLevelFeatures()

		for feature in features {
			tableViewData.append(TableViewData(level: feature.key, content: feature.value) )
		}
		tableViewData.sort(by: { $0.level < $1.level })


		//enable flexible table view heights
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190
    }

	@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
}

//MARK: TableView Methods
extension ClassDetailTableViewController {


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath)
		let cellFeature = tableViewData[indexPath.section].content[indexPath.row]

		cell.textLabel?.text 		= cellFeature.title
		cell.detailTextLabel?.text 	= cellFeature.description

		return cell

	}
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Level \(tableViewData[section].level)"
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if !tableViewData[section].content.isEmpty { return tableViewData[section].content.count  }
		else { return 1 }
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	struct TableViewData {
		let level: Int
		var content: [ClassFeature]
	}

}
