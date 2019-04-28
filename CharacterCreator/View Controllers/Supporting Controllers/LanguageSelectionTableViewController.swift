//
//  LanguageSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

class LanguageSelectionTableViewController: UITableViewController {

	var languages = [(sectionTitle: "common", 	languageData: [LanguageSelectionData]()),
					 (sectionTitle: "rare",		languageData: [LanguageSelectionData]())]

	var selectionsRemaining: Int? {
		didSet {
			updateNav()				}}

    override func viewDidLoad() {
        super.viewDidLoad()

		configureNav()

		registerCells()
		populateData()
    }

	private func configureNav() {
		guard let _ = navigationController  else { return }
			let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: .dismissLanguageSelection)
			navigationItem.rightBarButtonItem = backButton

			updateNav()
//			switch dataType {
//			case .ClassFeature: 		navigationItem.title 	= "\(target!.path.capitalized) Features"
//			case .Spellbook: 			navigationItem.title 	= "Spellbook"
	}

	private func updateNav() {
		guard let selectionsRemaining = selectionsRemaining else { return }
		navigationItem.title	= "Choose \(selectionsRemaining) more"
	}
	@objc func dismissLanguageSelection() {
		dismiss(animated: true, completion: nil)
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
		let source: String?
		let language: LanguageRecord
	}

	func populateData() {
		guard let commonLanguages = languageRecords["common"],
			let rareLanguages = languageRecords["rare"] else { return }

		var raceLearnedLanguages: [String] {
			guard let raceDict = raceData[Character.default.race.parentRace] as? [String : Any],
				let languages = raceDict["languages"] as? [String]
			else { print("could not generate race languages"); return [String]() }

			return languages
		}
		var backgroundLearnedLanguages: [String] {
			guard let backgroundDict = backgroundData[Character.default.background!.name] as? [String : Any],
				let languages = backgroundDict["languages"] as? [String]
				else { print("could not generate background languages"); return [String]() }

			return languages
		}
		let learnedLanguages = raceLearnedLanguages + backgroundLearnedLanguages
		let selectedLanguages = Character.default.languages.selected
		var selections: Int = learnedLanguages.filter{ $0 == "choice" }.count


		for language in commonLanguages {
			let isLearned = learnedLanguages.contains(language.name) ? true : false
			var source: String? {
				if isLearned {
					if raceLearnedLanguages.contains(where: { $0 == language.name }) {
						return "race"
					}
					if backgroundLearnedLanguages.contains(where: { $0 == language.name }) {
						return "background"
					}
					if selectedLanguages.contains(where: { $0.name == language.name}) {
						return "selected"
					}
				}
				return nil
			}

			let selectionData = LanguageSelectionData(isSelectable: !isLearned,
													  source: source,
													  language: language)
			languages[0].languageData.append(selectionData)
		}
		for language in rareLanguages {
			let isLearned = learnedLanguages.contains(language.name) ? true : false
			var source: String? {
				if isLearned {
					if raceLearnedLanguages.contains(where: { $0 == language.name }) {
						return "race"
					}
					if backgroundLearnedLanguages.contains(where: { $0 == language.name }) {
						return "background"
					}
				}
				return nil
			}

			let selectionData = LanguageSelectionData(isSelectable: !isLearned,
													  source: source,
													  language: language)
			languages[1].languageData.append(selectionData)
		}

	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
		let languageData = languages[indexPath.section].languageData[indexPath.row]
		let languageRecord = languageData.language
		let detailText: String = {
			var result = "Often spoken by \(languageRecord.spokenBy.lowercased())"

			if languageRecord.script != "-" {
				result.append("\nWritten in \(languageRecord.script) script")	}

			return result
		}()
		print(detailText)
		cell.selectionStyle	= .default

		cell.detailTextLabel?.numberOfLines	= 0

		cell.textLabel?.text 		= languageRecord.name.capitalized
		cell.detailTextLabel?.text	= detailText

		if !languageData.isSelectable {
			cell.selectionStyle = .none
			cell.textLabel?.textColor	= .lightGray
			cell.backgroundColor		= .darkGray
		}

        return cell
    }
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard selectionsRemaining != nil else { return }
		if selectionsRemaining! > 0 {
			selectionsRemaining! -= 1
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Common languages"
		case 1:
			return "Rare languages\n(Talk to your DM before selecting one of these languages.)"
		default:
			return ""
		}
	}

	private func registerCells() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
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

fileprivate extension Selector {
	static let dismissLanguageSelection = #selector(LanguageSelectionTableViewController.dismissLanguageSelection)

}

//fileprivate enum LanguageDataKey: String {
//	case common, rare
//}