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

    }

	private func loadTableData() {

		//name cell data
		let identityData = TableData(cellType: "identity", title: Character.default.flavorText.name,
									 attributes: ["age": Character.default.flavorText.age,
												  "alignment": Character.default.flavorText.alignment])
		tableData.append(identityData)



	}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	struct TableData {
		let cellType: String
		let title: String
		let attributes: [String : String]
	}

}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 9
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.row {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "IdentityCell") as! UITableViewCell

			return cell
		default:
			return UITableViewCell()
		}
	}
}
