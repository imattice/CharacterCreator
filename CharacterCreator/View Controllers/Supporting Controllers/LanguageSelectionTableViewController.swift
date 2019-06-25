//
//  LanguageSelectionTableViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

class LanguageSelectionTableViewController: UITableViewController {
	var dataSource = [(sectionTitle: "common", 	languageData: [LanguageSelectionData]()),
					 (sectionTitle: "rare",		languageData: [LanguageSelectionData]())]
	let availableSelections = Character.default.languages.innate.filter( { $0.isSelectable == true } ).count
	var selectionsRemaining: Int? {
		didSet {
			updateNav()				}}
	var selectedLanguages = [Language]()
	var delegate: LanguageSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.allowsMultipleSelection	= true

		configureNav()

		registerCells()
		populateData()
    }
	private func updateNav() {
		guard let selectionsRemaining = selectionsRemaining else { return }
		navigationItem.title	= "Choose \(selectionsRemaining) more"
	}

	private func configureNav() {
		guard let _ = navigationController  else { return }
			let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: .dismissLanguageSelection)
			navigationItem.leftBarButtonItem = backButton
			let confirmButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: .confirmSelection)
			navigationItem.rightBarButtonItem	= confirmButton

			updateNav()
	}
	@objc func confirmSelection() {
		delegate?.selectedLanguages = selectedLanguages
		dismiss(animated: true, completion: nil)
	}
	@objc func dismissLanguageSelection() {
		dismiss(animated: true, completion: nil)
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count		}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource[section].languageData.count	}

	struct LanguageSelectionData {
		let isSelectable: Bool
		let source: String?
		let language: Language
	}

	func populateData() {
			let commonLanguages = LanguageRecord.allRecords().filter({ $0.isRare == false })
			let rareLanguages = LanguageRecord.allRecords().filter({ $0.isRare == true })

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
		print(learnedLanguages)


		for record in commonLanguages {
			let isLearned = learnedLanguages.contains(record.name) ? true : false
			var source: String? {
				if isLearned {
					if raceLearnedLanguages.contains(where: { $0 == record.name }) {
						return "race"
					}
					if backgroundLearnedLanguages.contains(where: { $0 == record.name }) {
						return "background"
					}
					if selectedLanguages.contains(where: { $0.name == record.name}) {
						return "selected"
					}
				}
				return nil
			}

			let selectionData = LanguageSelectionData(isSelectable: !isLearned,
													  source: source,
													  language: record.language())
			dataSource[0].languageData.append(selectionData)
		}
		for record in rareLanguages {
			let isLearned = learnedLanguages.contains(record.name) ? true : false
			var source: String? {
				if isLearned {
					if raceLearnedLanguages.contains(where: { $0 == record.name }) {
						return "race"
					}
					if backgroundLearnedLanguages.contains(where: { $0 == record.name }) {
						return "background"
					}
				}
				return nil
			}

			let selectionData = LanguageSelectionData(isSelectable: !isLearned,
													  source: source,
													  language: record.language())
			dataSource[1].languageData.append(selectionData)
		}

	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
		let languageData = dataSource[indexPath.section].languageData[indexPath.row]
		let languageRecord = languageData.language
		let detailText: String = {
			var result = "Often spoken by \(languageRecord.spokenBy.lowercased())"

			if languageRecord.script != "-" {
				result.append("\nWritten in \(languageRecord.script) script")	}

			return result
		}()
		cell.selectionStyle	= .default

		cell.detailTextLabel?.numberOfLines	= 0

		cell.textLabel?.text 		= languageRecord.name.capitalized
		cell.detailTextLabel?.text	= detailText

		if !languageData.isSelectable {
			cell.selectionStyle = .none
			cell.textLabel?.textColor	= .lightGray
			cell.backgroundColor		= Character.default.class!.color().lightColor()
		}

        return cell
    }
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		guard selectionsRemaining != nil else { return true }
		if selectionsRemaining! <= 0 && !tableView.cellForRow(at: indexPath)!.isSelected { return false }
		return true

	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard selectionsRemaining != nil else { return }
		if selectionsRemaining! <= 0 { return }

		if selectionsRemaining! > 0 {
			selectionsRemaining! -= 1
		}

		let data = dataSource[indexPath.section].languageData[indexPath.row].language
		selectedLanguages.append(data)
//		Character.default.languages.selected.append(data)
	}

	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		guard selectionsRemaining != nil else { return }

		if selectionsRemaining! < availableSelections {
			selectionsRemaining! += 1
		}

		let data = dataSource[indexPath.section].languageData[indexPath.row].language
		guard let index = selectedLanguages.firstIndex(where: { $0.name == data.name }) else { return }
		selectedLanguages.remove(at: index)
//		Character.default.languages.selected.remove(at: index)
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
	static let confirmSelection			= #selector(LanguageSelectionTableViewController.confirmSelection)
}

//fileprivate enum LanguageDataKey: String {
//	case common, rare
//}
