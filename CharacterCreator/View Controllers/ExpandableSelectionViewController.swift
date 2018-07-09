//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//TODO: Close all other cells when a cell is selected

import UIKit

class ExpandableSelectionViewController: UIViewController {
	@IBOutlet weak var nextNavButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!

	//determines what kind of data to show
	
	@IBInspectable var dataType: String? = nil

	var tableViewData: [ExpandableCellData] 	= [ExpandableCellData]()
	var selectionWasMade: Bool 					= false


	override func viewDidLoad() {
        super.viewDidLoad()

		//ensure there is a data type; otherwise, remove the controller
		guard let dataType = dataType else { print("cannot do a thing with \(self.dataType!)"); navigationController?.popViewController(animated: true);  return }


		//configure the view controller based on the intended display data
		switch dataType.lowercased() {
		case "race":
			tableViewData = ExpandableCellData.createArray(forDataType: .race)

		case "class":
			tableViewData = ExpandableCellData.createArray(forDataType: .class)

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
			let indexPath = tableView.indexPath(for: parentCell),
			let storyboard = storyboard,
			let vc = storyboard.instantiateViewController(withIdentifier: "ClassDetail") as? ClassDetailTableViewController else { print("Could not instantiate Class Detail View Controller"); return }
		let navController = UINavigationController(rootViewController: vc)
		let cellData = tableViewData[indexPath.section]

		vc.targetClass = cellData.parentData.title.lowercased()
		vc.targetPath = cellData.childData![indexPath.row - 1].title.lowercased()
		vc.title = "\(cellData.parentData.title.capitalized)"

		print("initializing details for a \(vc.targetPath) \(vc.targetClass)")


//		vc.modalPresentationStyle = .overCurrentContext
//		navigationController?.pushViewController(vc, animated: true)
		present(navController, animated: true, completion: nil)
	}
}





//MARK: - Table View Data Source & Delegate
extension ExpandableSelectionViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		//configure parent cells
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ParentCell", for: indexPath) as! ParentTableViewCell
			let cellData = tableViewData[indexPath.section].parentData

			//reset dequeued cells
			cell.accessoryView 					= nil
			cell.selectionStyle 				= .default

			//prevent the parent cell from being selected if it has children
			//add chevron accessory
//			if tableViewData[indexPath.section].childData != nil {
//				cell.selectionStyle 			= .none
//
//				let chevronView 		= UIImageView(image: UIImage(named: "chevron"))
//					chevronView.frame 	= CGRect(x: 0, y: 0, width: 30, height: 30)
//					chevronView.alpha	= 0.8
//
//				cell.accessoryView				= chevronView
//				cell.accessoryView?.transform 	= CGAffineTransform(rotationAngle: 90°)
//			}

			//finish the label configuration
			cell.titleLabel.text 				= cellData.title
			cell.iconImageView.image 			= UIImage(named: cellData.title.lowercased())
			cell.descriptionLabel.text 			= cellData.description

			if dataType == "race" {
				//make the button look like a label
				cell.cornerButton.setTitleColor(.black, for: .normal)
				cell.cornerButton.isUserInteractionEnabled		= false

				cell.cornerButton.setTitle(Race.modifierString(for: cellData.title, withSubrace: nil), for: .normal )
			}

			if dataType == "class" {
				//remove th corner button for parent classes
				cell.cornerButton.isHidden 		= true
			}

			return cell																		}


		//configure child cells
		else {
			guard let data = tableViewData[indexPath.section].childData
				else { print("could not initialize subrace cell from data"); return UITableViewCell()}
			let parentData = tableViewData[indexPath.section].parentData
			let childData = data[indexPath.row - 1]

			if dataType == "race" {
				let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildTableViewCell

				cell.titleLabel.text 				= childData.title.capitalized
				cell.descriptionLabel.text 			= childData.description

				cell.cornerLabel.text				= Race.modifierString(for: parentData.title, withSubrace: childData.title)

				return cell																		}


			if dataType == "class" {
				let cell = tableView.dequeueReusableCell(withIdentifier: "PathCell", for: indexPath) as! ParentTableViewCell

				cell.titleLabel.text 				= childData.title.capitalized
				cell.descriptionLabel.text 			= childData.description

				cell.cornerButton.setTitle("Level +", for: .normal)
				cell.cornerButton.addTarget(self, action: #selector(showClassDetail(_:)), for: .touchUpInside)


				return cell																		}

			return UITableViewCell()
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

			//prevent the parent cell from indenting
//			guard let parentCell = tableView.cellForRow(at: indexPath) else { return }
//			tableView.cellForRow(at: indexPath)?.indentationLevel = 0

			//rotate the chevron
//			guard let accessoryView = parentCell.accessoryView else { return }
//			let rotation = CABasicAnimation(keyPath: "transform.rotation")
//				if tableViewData[indexPath.section].isOpen {
//					rotation.fromValue 	= 90°
//					rotation.toValue	= 270°	}
//				else {
//					rotation.fromValue 	= 270°
//					rotation.toValue	= 90°	}
//
//				rotation.duration	= 0.25
//
//				accessoryView.layer.add(rotation, forKey: nil)
//				accessoryView.transform 	= CGAffineTransform(rotationAngle: rotation.toValue as! CGFloat)

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
		tableView.register(UINib(nibName: String(describing: ParentTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "ParentCell")
		tableView.register(UINib(nibName: String(describing: ParentTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "PathCell")
		tableView.register(UINib(nibName: String(describing: ChildTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "ChildCell")
	}

}


//MARK: Segue Navigation
extension ExpandableSelectionViewController {
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

			print("Character's race is set to: \(String(describing: Character.current.race))")
		}

		if dataType == "class" {
			//ensure there is a path selected
			guard let selectedChildData = data.childData else { return }
			let selectedPath  = selectedChildData[selectedIndexPath.row - 1].title

			Character.current.class = Class(fromString: parentTitle, withPath: selectedPath)

			print("Character's class is set to: \(String(describing: Character.current.class))")
		}
	}

}


