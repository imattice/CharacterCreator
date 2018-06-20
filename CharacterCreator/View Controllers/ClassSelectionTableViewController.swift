//
//  ClassSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ClassSelectionTableViewController: UITableViewController {
	let classes: [String]  = ["Fighter",
							  "Monk",
							  "Rouge",
							  "Bard",
							  "Wizard",
							  "Warlock",
							  "Sourcerer",
							  ]

    override func viewDidLoad() {
        super.viewDidLoad()

         //Preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

		tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return classes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)

		cell.textLabel?.text = classes[indexPath.row]

        return cell
    }

    // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndex = tableView.indexPathForSelectedRow?.row  else { return }
		let selectedClass = classes[selectedIndex]

		Character.current.class = selectedClass
		print("Character's class is set to: \(String(describing: Character.current.class))")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
