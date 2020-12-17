//
//  TableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/22/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class WeaponSelectionTableViewController: UITableViewController {
	var tableViewData = [Item]()

	var selectionView: OldSelectionView?
	var weaponType: Weapon.Category?

    override func viewDidLoad() {
        super.viewDidLoad()

		registerCells()
		getTableData()
		configureNav()

		//enable flexible table view heights
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 190

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
    }

	private func getTableData() {
		guard let weaponType = weaponType else { print("weapon type not set"); return }
		var result = [Item]()
		var dataSource: [String] {
			switch weaponType {
			case .martial :	return MartialWeapons
			case .simple: 	return SimpleWeapons		} }

		for string in dataSource {
			if let weapon = WeaponRecord.record(for: string)?.weapon() {
				result.append(weapon)
				continue
			}

			let item = Item(string, type: .other)
			result.append(item)
		}

		tableViewData = result
		tableViewData.sort(by: { $0.name < $1.name })
	}

	private func configureNav() {
		if let _ = navigationController,
			let weaponType = weaponType {

			let backButton = UIBarButtonItem(barButtonSystemItem: .cancel,
											 target: self,
											 action: #selector(backButtonPressed(_:)))
			navigationItem.leftBarButtonItem = backButton

			let confirmButton = UIBarButtonItem(barButtonSystemItem: .save,
												target: self,
												action: #selector(confirmationButtonPressed(_:)))
			confirmButton.title = "Select"
			navigationItem.rightBarButtonItem = confirmButton


			switch weaponType {
				case .martial: navigationItem.title 	= "Martial Weapons"
				case .simple:	navigationItem.title	= "Simple Weapons"
			}
		}
	}

	@objc private func backButtonPressed(_ button: UIButton) {
		self.dismiss(animated: true, completion: nil)

	}

	@objc private func confirmationButtonPressed(_ button: UIButton) {
		if let indexPath = tableView.indexPathForSelectedRow,
			let selectionView = selectionView {
			let selectedItem = tableViewData[indexPath.row]

			selectionView.update(withItem: selectedItem)

			dismiss(animated: true, completion: nil)
		}

	}


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSelectionCell", for: indexPath) as! ItemSelectionTableViewCell
		let item = tableViewData[indexPath.row] as! Weapon

		cell.configure(for: item)

		return cell
	}
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableViewData.count
    }

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: ItemSelectionTableViewCell.self),	 bundle: nil), forCellReuseIdentifier: "ItemSelectionCell")
	}
}
