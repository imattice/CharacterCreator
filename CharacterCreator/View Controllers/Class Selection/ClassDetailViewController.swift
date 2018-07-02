//
//  ClassDetailViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

protocol ClassDetail {
	var targetClass: String { get }
	var selectedClass: Class { get set }
}

class ClassDetailViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	var tableViewData = [TableViewData]()
	var targetClass: String? 	= "cleric"

    override func viewDidLoad() {
        super.viewDidLoad()

		tableViewData = getData()
    }

	private func getData() -> [TableViewData] {
		guard let targetClass = targetClass,
			let classDict = classData[targetClass] as? [String : Any],
			let levels = classDict["levels"] as? [String : Any]
			else { print("could not initialize data for the \(self.targetClass!) class"); return [TableViewData]()}

		let result = [TableViewData]()

		for level in levels {
			guard let levelDict = level.value as? [String: Any]
				else {print("invalid level value for \(targetClass) at level \(level.key)"); return [TableViewData]() }
			let data = TableViewData(level: level.key, content: [TableViewData.LevelFeature]())

			for feature in levelDict {
				guard let value = feature.value as? String
					else { print("invalid level value for \(targetClass) at level \(level.key)"); return [TableViewData]() }
				let levelFeature = TableViewData.LevelFeature(title: feature.key, description: value)
			}
		}

		return result
	}
}

extension ClassDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewData[section].content.count
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	struct TableViewData {
		let level: String
		let content: [LevelFeature]

		struct LevelFeature {
			let title: String
			let description: String
		}
	}

}
