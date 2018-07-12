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
	var targetClass: String? 	= nil
	var targetPath: String?		= nil

    override func viewDidLoad() {
        super.viewDidLoad()

		//fill the tableviewdatasource with delicious content
		getLevelData()

		//enable flexible table view heights
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190
    }

	private func getLevelData() {
		//make sure we have the data we need
		guard let targetClass = targetClass 							else { print("the target class is nil"); return }
		guard let classDict = classData[targetClass] as? [String:Any],
			let classLevelDict = classDict["levels"] as? [String:Any] 	else { print("Could not initialize class data for the \(targetClass) class"); return}

		guard let targetPath = targetPath,
			let paths = classDict["paths"] as? [String:Any],
			let pathDict = paths[targetPath] as? [String:Any],
			let pathLevelDict = pathDict["levels"] as? [String:Any] 	else { print("could not initialize path data for the \(targetClass) class"); return}


		// get features for each level
		for level in 1...Character.levelMax {
			var levelFeatures = [TableViewData.LevelFeature]()

			//check for features for all classes
			if [4, 8, 12, 16, 19].contains(level) {
				let title = AllClassKey.abilityScoreIncrease.rawValue
				let dict = allClassLevels[title] as! [String: String]
				let description = dict["description"]!

				let levelFeature = TableViewData.LevelFeature(title: title, description: description, source: "All Classes")

				levelFeatures.append(levelFeature)
			}

			//check for class specific features
			if let classLevel = classLevelDict[String(level)] as? [String:Any] {
				let levelFeature = getFeatures(forDict: classLevel)

				levelFeatures.append(contentsOf: levelFeature)
			}

			//check for path specific features
			if let pathLevel = pathLevelDict[String(level)] as? [String:Any] {
				let levelFeature = getFeatures(forDict: pathLevel)

				levelFeatures.append(contentsOf: levelFeature)
			}

			// if we haven't found any features, skip this level
			if levelFeatures.isEmpty { continue }

			// add the level data to the table view data
			let levelData = TableViewData(level: level, content: levelFeatures)
			tableViewData.append(levelData)
		}

		//ensure the data is sorted by level
		tableViewData.sort(by: { $0.level < $1.level } )
	}

	private func getFeatures(forDict dict: [String: Any]) -> [TableViewData.LevelFeature] {
		var result = [TableViewData.LevelFeature]()

		for feature in dict {
			guard let description = feature.value as? String
				else { print("invalid level value for \(targetClass!) at level \(feature.key)"); return result }

			let levelFeature = TableViewData.LevelFeature(title: feature.key, description: description, source: targetPath!)

			result.append(levelFeature)
		}

		return result
	}

	@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
}

//MARK: TableView Methods
extension ClassDetailTableViewController {


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath)
			let cellData = tableViewData[indexPath.section].content[indexPath.row]

		cell.textLabel?.text 		= cellData.title
		cell.detailTextLabel?.text 	= cellData.description

		return cell

	}
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return String(tableViewData[section].level)
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if !tableViewData[section].content.isEmpty {
			return tableViewData[section].content.count  }
		else { return 1 }
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	struct TableViewData {
		let level: Int
		var content: [LevelFeature]

		struct LevelFeature {
			let title: String
			let description: String
			let source: String
		}
	}

}
