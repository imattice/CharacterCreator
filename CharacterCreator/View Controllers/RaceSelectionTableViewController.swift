//
//  RaceSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class RaceSelectionTableViewController: UITableViewController {
	let races: [String] = ["Human",
						   "Dwarf",
						   "Elf",
						   "Half-Elf",
						   "Halfling",
						   "Gnome",
						   "Dragonborn",
						   "Tiefling",
						   "Half-Orc"]

    override func viewDidLoad() {
        super.viewDidLoad()

        //preserves selection between presentations
         self.clearsSelectionOnViewWillAppear = false

		tableView.tableFooterView = UIView()
    }


    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath)

        cell.textLabel?.text = races[indexPath.row]

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedIndex = tableView.indexPathForSelectedRow?.row  else { return }
		let selectedRace = races[selectedIndex]

		Character.current.race = selectedRace
		print("Character's race is set to: \(String(describing: Character.current.race))")

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
