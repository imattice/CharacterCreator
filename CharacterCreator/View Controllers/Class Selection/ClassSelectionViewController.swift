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
	@IBOutlet weak var nextNavButton: UIBarButtonItem!

	var tableViewData: [ExpandableCellData] = [ExpandableCellData]()
	var selectionWasMade: Bool 					= false


    override func viewDidLoad() {
        super.viewDidLoad()

		tableViewData = ExpandableCellData.createArray(forDataType: .class)
		registerCells()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		tableView.tableFooterView = UIView()
    }

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
		let cellData = tableViewData[indexPath.section]

		//configure the class cell
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ParentTableViewCell
			let classData = cellData.parentData


			cell.titleLabel.text 				= classData.title.capitalized
			cell.descriptionLabel.text 			= classData.description
			cell.iconImageView.image 			= UIImage(named: classData.title.lowercased() )
			cell.cornerButton.isHidden			= true
	//		cell.cornerButton.tag 				= indexPath.row

	//		cell.cornerButton.setTitle("Level +", for: .normal)
	//		cell.cornerButton.addTarget(self, action: #selector(showClassDetail(_:)), for: .touchUpInside)

			return cell
		}
		//configure the path cell
		else {
			guard let childData = cellData.childData
				else { print("no path data available when attempting to create path cells for \(cellData.parentData.title)"); return UITableViewCell()}
			let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ParentTableViewCell
			print("\(indexPath)")
			let pathData = childData[indexPath.row - 1]

			cell.titleLabel.text 			= pathData.title.capitalized
			cell.descriptionLabel.text 		= pathData.description
			cell.iconImageView.isHidden		= true

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

			//prevent the parent cell from indenting
			guard let parentCell = tableView.cellForRow(at: indexPath) else { return }
			tableView.cellForRow(at: indexPath)?.indentationLevel = 0

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
		tableView.register(UINib(nibName: String(describing: ParentTableViewCell.self), bundle: nil), forCellReuseIdentifier: "ClassCell")
		tableView.register(UINib(nibName: String(describing: ChildTableViewCell.self), bundle: nil),  forCellReuseIdentifier: "PathCell")

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
