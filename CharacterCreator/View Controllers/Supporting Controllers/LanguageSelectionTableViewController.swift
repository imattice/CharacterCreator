//
//  LanguageSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

class LanguageSelectionTableViewController: UITableViewController {

	let languages = [(sectionTitle: "common", 	languageData: [LanguageSelectionData]()),
					 (sectionTitle: "rare",		languageData: [LanguageSelectionData]())]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return languages.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return languages[section].languageData.count
    }

	struct LanguageSelectionData {
		let isSelectable: Bool
		let source: String
		let language: LanguageRecord
	}

	func populateData() {

	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		let languageRecord = languages[indexPath.section].languageData[indexPath.row].language
		let detailText: String = {
			var result = "Often spoken by \(languageRecord.spokenBy.lowercased())"

			if languageRecord.script != "-" {
				result.append("/nWritten in \(languageRecord.script) script")	}

			return result
		}()

		cell.detailTextLabel?.numberOfLines	= 0

		cell.textLabel?.text 		= languageRecord.name
		cell.detailTextLabel?.text	= detailText

        return cell
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

fileprivate enum LanguageDataKey: String {
	case common, rare
}
