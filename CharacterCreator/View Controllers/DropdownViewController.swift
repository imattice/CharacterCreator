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
	var selectionWasMade: Bool 					= false


	override func viewDidLoad() {
        super.viewDidLoad()

		//ensure there is a data type; otherwise, remove the controller
		guard let dataType = dataType else { print("cannot do a thing with \(self.dataType!)"); navigationController?.popViewController(animated: true);  return }


		//configure the view controller based on the intended display data
		switch dataType.lowercased() {
		case "race":
			tableViewData = DropdownCellData.createArray(forDataType: .race)

		case "class":
			tableViewData = DropdownCellData.createArray(forDataType: .class)

		default:
			break;
		}

		//set up data and cells
		registerCells()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		//add a footer view to give space to the last row to expand
		tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))

		//turn off the navigation button if there is no selection made
		if !selectionWasMade { nextNavButton.isEnabled = false }
    }

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
		//selected child cell
//		else {
//			updateSelectedCellTintColor()
//		}
	}

	func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { print("could not create cell from deslected index \(indexPath)"); return }

		cell.contentView.backgroundColor = .white
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

			//if there are subraces available, check which subrace was selected
			if let subrace = data.childData {
				let subraceTitle = subrace[selectedIndexPath.row - 1].title

				Character.current.race = Race(fromParent: parentTitle, withSubrace: subraceTitle)						}

			//if there are no subraces, just use the parent race
			else {
				Character.current.race = Race(fromParent: parentTitle, withSubrace: nil)			}

//			print("Character's race is set to: \(String(describing: Character.current.race?.name))")
		}

		if dataType == "class" {
			//ensure there is a path selected
			guard let selectedChildData = data.childData else { return }
			let selectedClass = parentTitle
			let selectedPath  = selectedChildData[selectedIndexPath.row - 1].title

			Character.current.class = Class(fromString: selectedClass, withPath: selectedPath)

//			print("Character's class is set to: \(String(describing: Character.current.class?.name))")
		}
	}

}

extension DropdownViewController {
	private func updateSelectedCellTintColor() {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow,
			let selectedClass = AvailableClass(rawValue: tableViewData[selectedIndexPath.section].parentData.title.lowercased()) else { return }

		let color = UIColor.color(for: selectedClass)

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


