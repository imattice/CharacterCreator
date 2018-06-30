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

	var tableViewData: [TableViewData] = [TableViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

		tableViewData = fetchClassData()
		registerCells()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 190

		tableView.tableFooterView = UIView()
    }

	private func fetchClassData() -> [TableViewData] {
		var result: [TableViewData] = [TableViewData]()

		for data in classData {
			guard let classDict = data.value as? [String : Any] else { return [TableViewData]() }

//			print(classDict)

			//build the class summary
			if let description = classDict["description"] as? String,
				let hitDieData = classDict["hit_dice"] as? String,
				let hitDie = Int(hitDieData) {

				let classStruct 		= Class(name: data.key, hitDie: hitDie)
				let classDescription 	= description
				let tableData = TableViewData(value: classStruct, description: classDescription)

				result.append(tableData)

			} else { print("could not initialize the \(data.key) class from available data")}

		}

		return result
	}
}


// MARK: - Table view delegate and data source
extension ClassSelectionViewController: UITableViewDataSource, UITableViewDelegate {
	struct TableViewData {
		let value: Class
		let description: String
	}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ParentTableViewCell

		let cellData = tableViewData[indexPath.row]

		cell.titleLabel.text 		= cellData.value.name.capitalized
		cell.descriptionLabel.text 	= cellData.description
		cell.iconImageView.image 	= UIImage(named: cellData.value.name.lowercased() )
		cell.modifierLabel.isHidden = true

        return cell
    }

    // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndex = tableView.indexPathForSelectedRow?.row  else { return }
		let selectedClass = tableViewData[selectedIndex].value

		Character.current.class = selectedClass
		print("Character's class is set to: \(String(describing: Character.current.class))")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewData.count
	}

	private func registerCells() {
		tableView.register(UINib(nibName: "ParentTableViewCell", bundle: nil), forCellReuseIdentifier: "ClassCell")
	}

}
