//
//  ExpandableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/23/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ExpandableViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	var tableData = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()

		registerCells()

	}

}

extension ExpandableViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BackgroundCell", for: indexPath)

		return cell
	}

	private func registerCells() {
		tableView.register(UINib(nibName: String(describing: DropdownTableViewCell.self),bundle: nil), forCellReuseIdentifier: "BackgroundCell")
	}

}
