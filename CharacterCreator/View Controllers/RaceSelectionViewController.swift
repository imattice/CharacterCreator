//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//TODO: Close all other cells when a cell is selected

import UIKit

struct ExpandableCellData {
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
	@IBOutlet weak var nextNavButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!

	var tableViewData: [ExpandableCellData] = [ExpandableCellData]()

	var selectionWasMade: Bool = false


	override func viewDidLoad() {
        super.viewDidLoad()
		getRaceData()
		registerCells()

		if !selectionWasMade { nextNavButton.isEnabled = false }

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		tableView.tableFooterView = UIView()
    }

	private func getRaceData() {
		for race in raceData {

			//check if the race has subraces
			if let raceDict = race.value as? [String : Any],
				let subraces = raceDict["subraces"] as? [String : Any] {
				let data = ExpandableCellData(parentTitle: race.key.capitalized, childData: Array(subraces.keys))
				tableViewData.append(data) }

			//if there are no subraces, just show the parent race
			else {
				let data = ExpandableCellData(parentTitle: race.key.capitalized, childData: [String]())
				tableViewData.append(data) }
		}

//		for race in raceData {
//			//get parent race data
//			guard let raceDict = race.value as? [String : Any] else { return }
//
//			//check for parent modifiers
//			if let modifiers = raceDict["modifiers"] as? [String : Int] {
//
//			}
//
//			//check for subraces
//			if let subraceDict = raceDict["subraces"] as? [String : Any] {
//				for subrace in subraceDict {
//					let subraceName = subrace[""]
//				}
//
//				//check for subrace modifiers
//				if let modifiers =
//			}



			//if there are no subraces, just add the parent race


//		}
	}


	//MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow  else { return }
		let race 	= tableViewData[selectedIndexPath.section]

		//if there are subraces available, check which subrace was selected
		if !race.childData.isEmpty {
			let subrace = race.childData[selectedIndexPath.row]

			Character.current.race = subrace					}

		//if there are no subraces, just use the parent race
		else {
			Character.current.race = race.parentTitle  			}

		print("Character's race is set to: \(String(describing: Character.current.race))")
    }

}

//MARK: - Table View Data Source & Delegate
extension RaceSelectionViewController: UITableViewDataSource, UITableViewDelegate {


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let dataIndex = indexPath.row - 1

		//configure parent cells
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath)

			//reset dequeued cells
			cell.accessoryView 		= nil
			cell.selectionStyle 	= .default

			cell.textLabel?.text 	=  tableViewData[indexPath.section].parentTitle  //"Section: \(indexPath.section) Row: \(indexPath.row)"

			//prevent the parent cell from being selected if it has children
			//add chevron accessory
			if !tableViewData[indexPath.section].childData.isEmpty {
				cell.selectionStyle 			= .none

				let chevronView 		= UIImageView(image: UIImage(named: "chevron"))
					chevronView.frame 	= CGRect(x: 0, y: 0, width: 30, height: 30)
					chevronView.alpha	= 0.8

				cell.accessoryView				= chevronView
				cell.accessoryView?.transform 	= CGAffineTransform(rotationAngle: 90°)		}

			return cell																		}


		//configure child cells
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SubraceCell", for: indexPath) as! SubraceTableViewCell
//			let subraceName = tableViewData[indexPath.section].childData[indexPath.row]

			cell.titleLabel.text = tableViewData[indexPath.section].childData[dataIndex].capitalized //"Section: \(indexPath.section) Row: \(indexPath.row)"
//			cell.portraitImageView.image = UIImagÇe(named: subraceName)
//			cell.descriptionLabel
//			cell.modifierLabel =

			return cell																		}
	}


	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//ensure a proper selection was made before enabling the next button
		if indexPath.row == 0 { selectionWasMade = false; nextNavButton.isEnabled = false }
		if indexPath.row != 0 || tableViewData[indexPath.section].childData.isEmpty { selectionWasMade = true; nextNavButton.isEnabled = true }

		//selected parent cell
		if indexPath.row == 0 && !tableViewData[indexPath.section].childData.isEmpty {
			//toggle the cell open
			tableViewData[indexPath.section].isOpen = !tableViewData[indexPath.section].isOpen

			//expand the sections
			let sections = IndexSet.init(integer: indexPath.section)
			tableView.reloadSections(sections, with: .fade)

			//prevent the parent cell from indenting
			guard let parentCell = tableView.cellForRow(at: indexPath) else { return }
			tableView.cellForRow(at: indexPath)?.indentationLevel = 0

			//rotate the chevron
			guard let accessoryView = parentCell.accessoryView else { return }
			let rotation = CABasicAnimation(keyPath: "transform.rotation")
				if tableViewData[indexPath.section].isOpen {
					rotation.fromValue 	= 90°
					rotation.toValue	= 270°	}
				else {
					rotation.fromValue 	= 270°
					rotation.toValue	= 90°	}

				rotation.duration	= 0.25

				accessoryView.layer.add(rotation, forKey: nil)
				accessoryView.transform 	= CGAffineTransform(rotationAngle: rotation.toValue as! CGFloat)


		}
	}


	func numberOfSections(in tableView: UITableView) -> Int {

		return tableViewData.count
	}


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if tableViewData[section].isOpen {
			return tableViewData[section].childData.count + 1	}
		else {
			return 1											}
	}

	private func registerCells() {
		tableView.register(UINib(nibName: "SubraceTableViewCell", bundle: nil), forCellReuseIdentifier: "SubraceCell")
	}

}
