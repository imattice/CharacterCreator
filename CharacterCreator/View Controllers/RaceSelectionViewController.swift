//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//TODO: Close all other cells when a cell is selected

import UIKit

class RaceSelectionViewController: UIViewController {
	@IBOutlet weak var nextNavButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!

	var tableViewData: [ExpandableCellData] 	= [ExpandableCellData]()
	var selectionWasMade: Bool 					= false


	override func viewDidLoad() {
        super.viewDidLoad()

		//set up data and cells
		tableViewData = ExpandableCellData.createArray(forDataType: .race)  //createTableData()
		registerCells()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		//add a footer view to give space to the last row to expand
		tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))

		//turn off the navigation button if there is no selection made
		if !selectionWasMade { nextNavButton.isEnabled = false }
    }

//	private func createTableData() -> [ExpandableCellData] {
//		var result = [ExpandableCellData]()
//
//		for race in raceData {
//			guard let raceDict = race.value as? [String : Any],
//				let raceDescription = raceDict[RaceKey.description.rawValue] as? String
//				else { print("could not create the \(race.key) race from available data"); return [ExpandableCellData]() }
//
//			let parentRace: String 			= race.key
//			let parentDescription: String 	= raceDescription
//			var childData: [(title: String, description: String)]?
//
//			//check for available subraces
//			if let subraceDict = raceDict[RaceKey.subraces.rawValue] as? [String : [String: Any]] {
//				var subraceArray = [(title: String, description: String)]()
//
//				//loop through subraces
//				for subraceData in subraceDict {
//					//fetch the description
//					if let description = subraceData.value[RaceKey.description.rawValue] as? String {
//
//						subraceArray.append((title: subraceData.key, description: description))
//					}
//				}
//
//				childData = subraceArray
//			}
//
//			//create the data object here so we can add to it if there are subraces
//			var data = ExpandableCellData(title: parentRace, description: parentDescription)
//
//				if let subraces = childData {
//					data.childData = subraces
//				}
//
//				result.append(data)
//			}
//
//		return result
//	}

	private func modifierString(forRaceName raceName: String, withSubrace subraceName: String?) -> String {
		guard let raceData = raceData[raceName] as? [String : Any] else {print("invalid raceName: \(raceName)"); return ""}

		var result: String = ""
		var modifierArray: [String: Int]

		//set loop to subrace modifiers
		if let subraceName = subraceName {
			guard let subraces = raceData["subraces"] as? [String: Any],
				let subraceData = subraces[subraceName] as? [String: Any],
				let modifiers = subraceData["modifiers"] as? [String : Int] else {print("invalid modifiers for subrace"); return "" }
			modifierArray = modifiers

		//set loop to parent modifiers
		} else {
			guard let modifiers = raceData["modifiers"] as? [String : Int] else {print("invalid modifiers for parent race"); return "" }

			modifierArray = modifiers
		}


		//append each modifier to the result
		for modifier in modifierArray { result += "+ \(modifier.key.capitalized) " }

		return result.replacingOccurrences(of: "_", with: " ").trimmingCharacters(in: .whitespaces)
	}
}





//MARK: - Table View Data Source & Delegate
extension RaceSelectionViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		//configure parent cells
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath) as! ParentTableViewCell

			//reset dequeued cells
			cell.accessoryView 					= nil
			cell.selectionStyle 				= .default

			//prevent the parent cell from being selected if it has children
			//add chevron accessory
			if tableViewData[indexPath.section].childData != nil {
				cell.selectionStyle 			= .none

				let chevronView 		= UIImageView(image: UIImage(named: "chevron"))
					chevronView.frame 	= CGRect(x: 0, y: 0, width: 30, height: 30)
					chevronView.alpha	= 0.8

				cell.accessoryView				= chevronView
				cell.accessoryView?.transform 	= CGAffineTransform(rotationAngle: 90°)
			}

			//make the button look like a label
			cell.cornerButton.setTitleColor(.black, for: .normal)
			cell.cornerButton.isUserInteractionEnabled		= false

			//finish the label configuration
			let parentRace = tableViewData[indexPath.section].parentData.title

			cell.titleLabel.text 				= parentRace
			cell.iconImageView.image 			= UIImage(named: parentRace.lowercased())
			cell.descriptionLabel.text 			= tableViewData[indexPath.section].parentData.description

			cell.cornerButton.setTitle(modifierString(forRaceName: parentRace, withSubrace: nil), for: .normal )

			return cell																		}


		//configure child cells
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "SubraceCell", for: indexPath) as! ChildTableViewCell
			guard let childData = tableViewData[indexPath.section].childData
				else { print("could not initialize subrace cell from data"); return UITableViewCell()}
			let parentData = tableViewData[indexPath.section].parentData
			let subraceData = childData[indexPath.row - 1]
			let subraceTitle = subraceData.title

			cell.titleLabel.text 				= subraceTitle.capitalized
			cell.descriptionLabel.text 			= subraceData.description
			cell.modifierLabel.text				= modifierString(forRaceName: parentData.title, withSubrace: subraceTitle)

			return cell																		}
	}


	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//enable the next button if a race can be set from the selection
		if indexPath.row == 0 { selectionWasMade = false; nextNavButton.isEnabled = false }
		if indexPath.row != 0 || tableViewData[indexPath.section].childData == nil { selectionWasMade = true; nextNavButton.isEnabled = true }


		//selected parent cell
		if indexPath.row == 0 && tableViewData[indexPath.section].childData != nil {
			//send the selected cell to the top
			tableView.scrollToRow(at: indexPath, at: .top, animated: true)

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

			//scroll the selected cell to the top
			tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
		tableView.register(UINib(nibName: String(describing: ParentTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "RaceCell")
		tableView.register(UINib(nibName: String(describing: ChildTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "SubraceCell")
	}

}


//MARK: Segue Navigation
extension RaceSelectionViewController {
	//MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow  else { return }
		let data = tableViewData[selectedIndexPath.section]
		let raceTitle = data.parentData.title

		//if there are subraces available, check which subrace was selected
		if let subrace = data.childData {
			let subraceTitle = subrace[selectedIndexPath.row - 1].title

			Character.current.race = Race(fromParent: raceTitle, withSubrace: subraceTitle)						}

		//if there are no subraces, just use the parent race
		else {
			Character.current.race = Race(fromParent: raceTitle, withSubrace: nil)			}

		print("Character's race is set to: \(String(describing: Character.current.race))")
	}

}


