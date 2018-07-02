//
//  ClassSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//view class icon
//view name
//view description

//view hit point die
//view armor, weapons, and tool profieciency
//view saving throws
//view innate class abilities
//view leveling options


//select class
//select skill profieciencies
//select equiptment for class before advancing
//select spells for class before advancing
//select class path - domains, school of magic..etc
//other class specific choices


import UIKit

class ClassSelectionViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	var tableViewData: [ExpandableCellData] = [ExpandableCellData]()
	var selectedClass: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		tableViewData = ExpandableCellData.createArray(forDataType: .class)
		registerCells()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		tableView.tableFooterView = UIView()
    }

//	private func fetchClassData() -> [ExpandableCellData] {
//		var result: [ExpandableCellData] = [ExpandableCellData]()
//
//		for data in classData {
//			guard let classDict = data.value as? [String : Any] else { return [ExpandableCellData]() }
//
////			print(classDict)
//
//			//build the class summary
//			if let description = classDict["description"] as? String,
//				let hitDieData = classDict["hit_dice"] as? String,
//				let hitDie = Int(hitDieData) {
//
//				let classDescription 	= description
//				let tableData = ExpandableCellData(title: data.key, description: classDescription)
//
//				//check for class paths
//				if let pathsDict = classDict[ClassKey.path.rawValue] as? [String : Any] {
//
//					//loop through each path
//					for path in pathsDict {
//						let pathOptions = [(title: String, description: String)]
//						let pathName = path.key
//						guard let pathDetails = path.value as? [String : Any],
//							let pathDescription = pathDetails[ClassKey.description.rawValue] as? String
//						else { print("toruble creating path for \(pathName)"); return result}
//
//						let pathData = (object: pathName, description: pathDescription)
//					}
//
//
//				}
//
//				result.append(tableData)
//
//			} else { print("could not initialize the \(data.key) class from available data")}
//
//		}
//
//		return result
//	}

	@objc func showClassDetail(_ sender: UIButton) {
		
		guard let storyboard = storyboard, let vc = storyboard.instantiateViewController(withIdentifier: "ClassDetail") as? ClassDetailViewController else { print("Could not instantiate Class Detail View Controller"); return }

		vc.targetClass = tableViewData[sender.tag].parentData.title

		self.present(vc, animated: true, completion: nil)
	}
}


// MARK: - Table view delegate and data source
extension ClassSelectionViewController: UITableViewDataSource, UITableViewDelegate {
//	struct TableViewData {
//		let value: Class
//		let description: String
//	}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ParentTableViewCell

		let cellData = tableViewData[indexPath.row]

		cell.titleLabel.text 				= cellData.parentData.title.capitalized
		cell.descriptionLabel.text 			= cellData.parentData.description
		cell.iconImageView.image 			= UIImage(named: cellData.parentData.title.lowercased() )
		cell.cornerButton.tag 				= indexPath.row

		cell.cornerButton.setTitle("Level +", for: .normal)
		cell.cornerButton.addTarget(self, action: #selector(showClassDetail(_:)), for: .touchUpInside)

		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ParentTableViewCell

		}
//			let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath) as! ParentTableViewCell
//
//			//reset dequeued cells
//			cell.accessoryView 					= nil
//			cell.selectionStyle 				= .default
//
//			//prevent the parent cell from being selected if it has children
//			//add chevron accessory
//			if tableViewData[indexPath.section].childData != nil {
//				cell.selectionStyle 			= .none
//
//				let chevronView 		= UIImageView(image: UIImage(named: "chevron"))
//				chevronView.frame 	= CGRect(x: 0, y: 0, width: 30, height: 30)
//				chevronView.alpha	= 0.8
//
//				cell.accessoryView				= chevronView
//				cell.accessoryView?.transform 	= CGAffineTransform(rotationAngle: 90°)
//			}
//
//			//make the button look like a label
//			cell.cornerButton.setTitleColor(.black, for: .normal)
//			cell.cornerButton.isUserInteractionEnabled		= false
//
//			//finish the label configuration
//			let parentRace = tableViewData[indexPath.section].parentData
//			let modifierString = tableViewData[indexPath.section].parentData.modifierString()
//
//			cell.titleLabel.text 				= tableViewData[indexPath.section].parentData.name
//			cell.iconImageView.image 			= UIImage(named: parentRace.name.lowercased())
//			cell.descriptionLabel.text 			= tableViewData[indexPath.section].description
//
//			cell.cornerButton.setTitle(modifierString, for: .normal )
//
//			return cell																		}
//
//
//			//configure child cells
//		else {
//			let cell = tableView.dequeueReusableCell(withIdentifier: "SubraceCell", for: indexPath) as! ChildTableViewCell
//			guard let data = tableViewData[indexPath.section].childData
//				else { print("could not initialize subrace cell from data"); return UITableViewCell()}
//			let subraceData = data[indexPath.row - 1]
//
//			cell.titleLabel.text 				= subraceData.race.name.capitalized
//			cell.descriptionLabel.text 			= subraceData.description
//			cell.modifierLabel.text				= subraceData.race.modifierString()
//
//			return cell																		}
//
//
        return cell
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewData.count
	}

	private func registerCells() {
		tableView.register(UINib(nibName: "ParentTableViewCell", bundle: nil), forCellReuseIdentifier: "ClassCell")
	}
}

// MARK: - Navigation
extension ClassSelectionViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndexPath = tableView.indexPathForSelectedRow,
			let selectedChildData = tableViewData[selectedIndexPath.section].childData else { return }
			let selectedClass = tableViewData[selectedIndexPath.section].parentData.title
			let selectedPath  = selectedChildData[selectedIndexPath.row].title

		Character.current.class = Class(fromString: selectedClass, withPath: selectedPath)
		print("Character's class is set to: \(String(describing: Character.current.class))")
	}
}
