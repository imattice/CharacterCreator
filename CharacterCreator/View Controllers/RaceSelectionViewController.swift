//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//TODO: Close all other cells when a cell is selected

import UIKit

//struct ExpandableCellData {
//	var isOpen: Bool 			= false
//
//	var parentTitle: String
//	var childData: [String]
//
//
//	init(parentTitle: String, childData: [String]) {
//		self.isOpen 		= false
//		self.parentTitle 	= parentTitle
//		self.childData		= childData
//	}
//}

struct ExpandableCellData {
	var isOpen: Bool 			= false

		var parentData: Race
		var description: String
		var childData: [(race: Race, description: String)]?


	init(parentData: Race, description: String) {
		self.isOpen 		= false
		self.parentData 	= parentData
		self.description	= description
	}
}

class RaceSelectionViewController: UIViewController {
	@IBOutlet weak var nextNavButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!

	var tableViewData: [ExpandableCellData] = [ExpandableCellData]()

	var selectionWasMade: Bool = false


	override func viewDidLoad() {
        super.viewDidLoad()
		tableViewData = createTableData()
		registerCells()

		if !selectionWasMade { nextNavButton.isEnabled = false }

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		tableView.tableFooterView = UIView()
    }

//	private func getRaceData() {
//		for race in raceData {
//
//			//check if the race has subraces
//			if let raceDict = race.value as? [String : Any],
//				let subraces = raceDict["subraces"] as? [String : Any] {
//				let data = ExpandableCellData(parentTitle: race.key.capitalized, childData: Array(subraces.keys))
//				tableViewData.append(data) }
//
//			//if there are no subraces, just show the parent race
//			else {
//				let data = ExpandableCellData(parentTitle: race.key.capitalized, childData: [String]())
//				tableViewData.append(data) }
//		}
//	}

	private func createTableData() -> [ExpandableCellData] {
		var result = [ExpandableCellData]()

		for race in raceData {
			var parentRace: Race?
			var parentDescription: String?
			var childData: [(race: Race, description: String)]?

			guard let raceDict = race.value as? [String : Any] else { return [ExpandableCellData]() }

			//build the parent race
			//fetch the description
			if let description = raceDict["description"] as? String,
				let modifiers = raceDict["modifiers"] as? [String : Int] {

				var parentModifiers = [Modifier]()

				for (key, value) in modifiers {
					let modifier = Modifier(type: key, value: value, origin: race.key.capitalized)
					parentModifiers.append(modifier)
				}

				parentRace 			= Race(name: race.key.capitalized, subrace: nil, modifiers: parentModifiers)
				parentDescription 	= description

			} else { print("could not create the \(race.key) race from available data")}

			//build the subraces array
			if let subraceDict = raceDict["subraces"] as? [String : [String: Any]] {
				var subraceArray = [(race: Race, description: String)]()

				for subrace in subraceDict {

					//check for subrace modifiers
					if let description = subrace.value["description"] as? String,
						let modifiers = subrace.value["modifiers"] as? [String : Int] {

						var subraceModifiers = [Modifier]()

						for (key, value) in modifiers {
							let modifier = Modifier(type: key, value: value, origin: race.key.capitalized)
							subraceModifiers.append(modifier)
						}
						let sub = Race(name: subrace.key,
									  subrace: nil,
									  modifiers: subraceModifiers)

						subraceArray.append((race: sub, description: description))

					}
				}
				childData = subraceArray
			} else {  }

			//unwrap and add to the collection
			if let race = parentRace,
				let description = parentDescription {

				//create the data object so we can add to it if there are subraces
				var data = ExpandableCellData(parentData: race, description: description)

				if let subraces = childData {
					data.childData = subraces
				}

				result.append(data)
			}


		}

		return result
	}





	//MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow  else { return }
		let data = tableViewData[selectedIndexPath.section]

		//if there are subraces available, check which subrace was selected
		if let subrace = data.childData {
			let race = subrace[selectedIndexPath.row].race

			Character.current.race = race						}

		//if there are no subraces, just use the parent race
		else {
			Character.current.race = data.parentData  			}

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

			cell.textLabel?.text 	= tableViewData[indexPath.section].parentData.name  //"Section: \(indexPath.section) Row: \(indexPath.row)"

			//prevent the parent cell from being selected if it has children
			//add chevron accessory
			if tableViewData[indexPath.section].childData != nil {
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
			guard let subrace = tableViewData[indexPath.section].childData else { print("could not initialize subrace cell from data"); return UITableViewCell()}

			cell.titleLabel.text = subrace[dataIndex].race.name.capitalized //"Section: \(indexPath.section) Row: \(indexPath.row)"
//			cell.portraitImageView.image = UIImagÇe(named: subraceName)
//			cell.descriptionLabel
//			cell.modifierLabel =

			return cell																		}
	}


	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//ensure a proper selection was made before enabling the next button
		if indexPath.row == 0 { selectionWasMade = false; nextNavButton.isEnabled = false }
		if indexPath.row != 0 || tableViewData[indexPath.section].childData == nil { selectionWasMade = true; nextNavButton.isEnabled = true }

		//selected parent cell
		if indexPath.row == 0 && tableViewData[indexPath.section].childData != nil {
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

		if tableViewData[section].isOpen && tableViewData[section].childData != nil {
			return tableViewData[section].childData!.count + 1	}
		else {
			return 1											}
	}

	private func registerCells() {
		tableView.register(UINib(nibName: "SubraceTableViewCell", bundle: nil), forCellReuseIdentifier: "SubraceCell")
	}

}
