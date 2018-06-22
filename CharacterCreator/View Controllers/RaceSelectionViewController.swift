//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

struct cellData {
	var isOpen: Bool 			= false
	var parentTitle: String
	var childData: [String]

	init(parentTitle: String, childData: [String]) {
		self.isOpen 		= false
		self.parentTitle 	= parentTitle
		self.childData		= childData
	}
}

class RaceSelectionViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	var tableViewData = [cellData]()
	
	let raceNames: [String] 	= Array(raceData.keys)
//	let subraceNames: [String] 	= {
//		let result = [String]()
//		for name in raceNames {
//			guard let race = raceData[name] as [String: Any],
//			let subraces = race["subraces"] as [String: Any] else { return }
//			result.append(Array(subraces.keys))
//
//		}
//		print("Subrace names: \(result)")
//		return result
//	}()

	//https://www.youtube.com/watch?v=b1LiBiLjca4

    override func viewDidLoad() {
        super.viewDidLoad()

		for race in raceData {
			if let raceDict = race.value as? [String : Any],
				let subraces = raceDict["subraces"] as? [String : Any] {
				print(subraces.keys)

				let data = cellData(parentTitle: race.key.capitalized, childData: Array(subraces.keys))
				tableViewData.append(data)
			} else {
				let data = cellData(parentTitle: race.key.capitalized, childData: [String]())
				tableViewData.append(data)
			}
		}

		tableViewData.append(contentsOf: [ cellData(parentTitle: "title1", childData: ["cell1", "cell2", "cell3", "cell4"]),
										   cellData(parentTitle: "title2", childData: ["cell1", "cell2", "cell3", "cell4"]),
										   cellData(parentTitle: "title3", childData: ["cell1", "cell2", "cell3", "cell4"]),
										cellData(parentTitle: "title4", childData: ["cell1", "cell2", "cell3", "cell4"]) ])

        //preserves selection between presentations
//		tableView.clearsSelectionOnViewWillAppear = false

		tableView.tableFooterView = UIView()
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndex = tableView.indexPathForSelectedRow?.row  else { return }
		let selectedRace = raceNames[selectedIndex]

		Character.current.race = selectedRace
		print("Character's race is set to: \(String(describing: Character.current.race))")

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

//MARK: - Table View Data Source & Delegate
extension RaceSelectionViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return raceNames.count
		if tableViewData[section].isOpen {
			return tableViewData[section].childData.count + 1
		} else {
			return 1
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath) // else { return UITableViewCell() }
		let dataIndex = indexPath.row - 1

		if indexPath.row == 0 {
			cell.textLabel?.text = tableViewData[indexPath.section].parentTitle
			return cell
		} else {
			cell.textLabel?.text = tableViewData[indexPath.section].childData[dataIndex]
//			cell.layoutMargins.left = 30
			return cell
		}
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
//			print("here")
			if tableViewData[indexPath.section].isOpen {
				tableViewData[indexPath.section].isOpen = false
			} else {
				tableViewData[indexPath.section].isOpen = true
			}
			let sections = IndexSet.init(integer: indexPath.section)
			tableView.reloadSections(sections, with: .none)
		}
	}
}
