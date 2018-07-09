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

		tableViewData = getPathLevels()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

    }

	//TODO: This method seems pretty heavy handed.  There's probably a better way to do this. 🤔
	private func getPathLevels() -> [TableViewData] {
			//class variables
		guard let targetClass = targetClass,
			let classDict = classData[targetClass] as? [String : Any],
			let classLevels = classDict["levels"] as? [String : Any]
				else { print("could not initialize class data for the \(self.targetClass!) class");
					return [TableViewData]()}

			//path variables
		guard let targetPath = targetPath,
			let paths = classDict["paths"] as? [String: Any],
			let pathDict = paths[targetPath] as? [String: Any],
			let pathLevels = pathDict["levels"] as? [String: Any]
			else { print("could not initialize path data for the \(self.targetClass!) class");
	 	return [TableViewData]() }

		var result = [TableViewData]()
		var appendedLevels = [Int]()

		
		//get the path levels
		for classLevel in classLevels {

			//dig through each level value
			guard let classLevelDict = classLevel.value as? [String: Any]
				else {print("invalid level value for \(targetClass) at level \(classLevel.key)"); return result }

			//grab each feature for the current level
			var levelFeatures = getFeatures(forDict: classLevelDict)

			//check if there are path levels for the current class level
			for pathLevel in pathLevels {
				guard let pathLevelDict = pathLevel.value as? [String: Any]
					else {print("invalid level value for \(targetPath) at level \(pathLevel.key)"); return result }

				let pathFeatures = getFeatures(forDict: pathLevelDict)

				//if the level key matches the current class level, combine the level features
				if pathLevel.key == classLevel.key {

					levelFeatures.append(contentsOf: pathFeatures)

					//leave the path check loop
					continue
				}
			}

			//return the data from this level
			let levelData = TableViewData(level: Int(classLevel.key)!, content: levelFeatures)
				result.append(levelData)
				appendedLevels.append(levelData.level)
		}

		//sweep through the paths to grab any level features that were not combined with class levels
		for pathLevel in pathLevels {
			guard let pathLevelDict = pathLevel.value as? [String: Any]
				else {print("invalid level value for \(targetPath) at level \(pathLevel.key)"); return result }

			// check if a combined level was already added
			if appendedLevels.contains(Int(pathLevel.key)!) { continue }

			//if not, add a path level option
			else {
				let pathFeatures = getFeatures(forDict: pathLevelDict)
				let pathData = TableViewData(level: Int(pathLevel.key)!, content: pathFeatures)
					result.append(pathData)
					appendedLevels.append(pathData.level)
			}
		}

		//return the result, sorted by level
		return result.sorted(by: { $0.level < $1.level } )
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
