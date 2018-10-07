//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//TODO: Close all other cells when a cell is selected

import UIKit

class DropdownViewController: UIViewController {
	@IBOutlet weak var nextNavButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!

	//determines what kind of data to show
	@IBInspectable var dataType: String? = nil

	var tableViewData: [DropdownCellData] 	= [DropdownCellData]()
	var selectionWasMade: Bool 				= false
	var selectedRace: Race?					= nil


	override func viewDidLoad() {
        super.viewDidLoad()

		//ensure there is a data type; otherwise, remove the controller
		//this is currently set in the storyboard
		guard let dataTypeString = dataType,
			let dataType = DataType(rawValue: dataTypeString)
			else { print("cannot present data with \(self.dataType!)"); navigationController?.popViewController(animated: true);  return }

		if let selectedRace = selectedRace { print("selected race: \(selectedRace.name())")}


		//set up data and cells
		registerCells()
		tableViewData = DropdownCellData.array(forDataType: dataType)

		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 190

		//add a footer view to give space to the last row to expand
		tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))

		//turn off the navigation button if there is no selection made
		if !selectionWasMade { nextNavButton.isEnabled = false }
    }

	//presents a modal view to show class level progression
	@objc func showClassDetail(_ sender: UIButton) {
		guard let contentView = sender.superview,
			let parentCell = contentView.superview as? UITableViewCell,
			let indexPath = tableView.indexPath(for: parentCell)
			else { print("Could not instantiate Class Detail View Controller"); return }

		let vc = ModalTableViewController()
		let navController = UINavigationController(rootViewController: vc)
		let cellData = tableViewData[indexPath.section]

		vc.target = Class(fromString: cellData.parentData.title.lowercased(),
						  withPath: cellData.childData![indexPath.row - 1].title.lowercased())
		vc.dataType = .ClassFeature

		present(navController, animated: true)
	}
}




//MARK: - Table View Data Source & Delegate
extension DropdownViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		//configure parent cells
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ParentCell", for: indexPath) as! DropdownTableViewCell
			cell.configure(forDataType: dataType!, withData: tableViewData[indexPath.section], at: indexPath)

			return cell																		}

		//configure child cells
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "PathCell", for: indexPath) as! DropdownTableViewCell
			cell.configure(forDataType: dataType!, withData: tableViewData[indexPath.section], at: indexPath)
			cell.removeImageView()

			if dataType == "class" {
				cell.cornerButton.addTarget(self, action: #selector(showClassDetail(_:)), for: .touchUpInside)
			}

			return cell

		}
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

			//scroll the selected cell to the top
			tableView.scrollToRow(at: indexPath, at: .top, animated: true)
		}
	}

	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { print("could not create cell from deslected index \(indexPath)"); return }

		cell.contentView.backgroundColor = .white
	}


	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewData.count }


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableViewData[section].isOpen && tableViewData[section].childData != nil {
			return tableViewData[section].childData!.count + 1	}
		else {
			return 1											}

	}

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: DropdownTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "ParentCell")
		tableView.register(UINib(nibName: String(describing: DropdownTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "PathCell")
	}

	

}


//MARK: Segue Navigation
extension DropdownViewController {
	//MARK: - Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow  else { return }
		let data = tableViewData[selectedIndexPath.section]
		let parentTitle = data.parentData.title

		if dataType == "race" {
			guard let desintationVC = segue.destination as? DropdownViewController else { print("could not cast VC to DropdownViewController when naving to Class Selection"); return }
			var destinationRace: Race?

			//if there are subraces available, check which subrace was selected
			if let subrace = data.childData {
				let subraceTitle = subrace[selectedIndexPath.row - 1].title

				destinationRace = Race(fromParent: parentTitle, withSubrace: subraceTitle)
			}
			else {
				destinationRace = Race(fromParent: parentTitle, withSubrace: nil)
			}

			desintationVC.selectedRace = destinationRace

		}

		if dataType == "class" {
			//ensure there is a path selected
			guard let selectedChildData = data.childData,
				let selectedRace = selectedRace,
				let selectedClass = Class(fromString: parentTitle, withPath: selectedChildData[selectedIndexPath.row - 1].title)
				else { return }

			Character.current.race	= selectedRace
			Character.current.class	= selectedClass
		}
	}

}

extension DropdownViewController {
	private func updateSelectedCellTintColor() {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow,
			let selectedClass = AvailableClass(rawValue: tableViewData[selectedIndexPath.section].parentData.title.lowercased()) else { return }

		let color = UIColor.color(for: selectedClass).base()

		UIView.animate(withDuration: 1,
					   delay: 0,
					   usingSpringWithDamping: 0.8,
					   initialSpringVelocity: 0.5,
					   options: .curveLinear,
					   animations: {
							self.navigationItem.backBarButtonItem?.tintColor	= color
							self.navigationItem.leftBarButtonItem?.tintColor 	= color
							self.navigationItem.rightBarButtonItem?.tintColor 	= color

						},
					   completion: nil)
	}
}


struct DropdownCellData {
	//tracks if the cell is open or closed
	var isOpen: Bool 			= false

	var parentData: (title: String, description: String)
	var childData: [(title: String, description: String)]?


	init(title: String, description: String) {
		self.isOpen 		= false
		self.parentData 	= (title: title, description: description)
	}

	static func array(forDataType dataType: DataType) -> [DropdownCellData] {
		let sourceArray: [String: Any]
		let childKey: String

		var result = [DropdownCellData]()

		//set source-specific values
		switch dataType {
		case .class: 	sourceArray = classData; childKey = "paths"
		case .race:		sourceArray = raceData;  childKey = "subraces"
		}

		//loop through parent data
		for parent in sourceArray {
			guard let parentDict = parent.value as? [String : Any],
				let description = parentDict["description"] as? String
				else { print("could not create \(parent.key) parent data from available data"); return [DropdownCellData]() }

			let parentTitle: String 			= parent.key
			let parentDescription: String 		= description
			var childData: [(title: String, description: String)]?

			//check for available childData
			if let childDict = parentDict[childKey] as? [String : [String: Any]] {
				var childArray = [(title: String, description: String)]()

				//loop through child Data
				for childData in childDict {

					//fetch the description
					if let description = childData.value["description"] as? String {

						childArray.append((title: childData.key, description: description))
					}
				}
				childData = childArray.sorted(by: { $0.title < $1.title })
			}

			//create the data object here so we can add to it if there is child data
			var parentData = DropdownCellData(title: parentTitle, description: parentDescription)

			if childData != nil {
				parentData.childData = childData
			}

			result.append(parentData)
		}

		return result.sorted(by: { $0.parentData.title < $1.parentData.title })
	}

}



