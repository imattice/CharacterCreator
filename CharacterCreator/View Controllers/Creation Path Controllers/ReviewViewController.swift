//
//  ReviewViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	var tableData = [TableData]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		loadTableData()

		tableView.estimatedRowHeight = 100.0
		tableView.rowHeight = UITableView.automaticDimension
    }

	private func loadTableData() {

		//name cell data
		let identityData = TableData(cellType: "identity", title: Character.default.flavorText.name,
									 attributes: ["age": Character.default.flavorText.age,
												  "alignment": Character.default.flavorText.alignment])
		tableData.append(identityData)



	}


	struct TableData {
		let cellType: String
		let title: String
		let attributes: [String : String]
	}

	@IBAction func printButtonTapped(_ sender: UITapGestureRecognizer) {
		print("print this!")
	}
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 8
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "IdentityCell") as! IdentityReviewTableViewCell
				cell.config()
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell") as! RaceReviewTableViewCell
				cell.config()
			return cell
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell") as! ClassReviewTableViewCell
			cell.config()
			return cell
		case 3:
			let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell") as! StatReviewTableViewCell
				cell.config()
			return cell
		case 4:
			let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell") as! SpellReviewTableViewCell
				cell.config()
			return cell
		case 5:
			let cell = tableView.dequeueReusableCell(withIdentifier: "BackgroundCell") as! BackgroundReviewTableViewCell
			cell.config()
			return cell
		case 6:
			let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell") as! SkillReviewTableViewCell
			cell.config()
			return cell
		case 7:
			let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell") as! InventoryReviewTableViewCell
			cell.config()
			return cell
		default:
			return UITableViewCell()
		}
	}
}
