//
//  CollectionSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class AbilitySelectionViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var headerMessage: UILabel!
	@IBOutlet weak var proficiencyCountLabel: UILabel!

	var collectionViewData = [CollectionViewData]()

	var selectedProficiencies: [String] = [String]()


	override func viewDidLoad() {
		super.viewDidLoad()

		collectionViewData = loadCollectionViewData()

		collectionView.allowsMultipleSelection = true
		registerCells()

		updateProficiencyCountLabel(animated: false)

		navigationItem.rightBarButtonItem?.isEnabled = false

		headerMessage.text = "Remaining Checks:"
	}

	func updateProficiencyCountLabel(animated: Bool) {
		guard let labelText = proficiencyCountLabel.text,
			let currentValue = Int(labelText)
			else { print("could not establish an Int from the proficiency count label text"); return }
		let selectionLimit = Character.current.proficiencyChoiceCount()
		let selectionsMade = selectedProficiencies.count
		let nextValue = selectionLimit - selectionsMade
		let animationDirection: UIView.AnimationOptions = currentValue > nextValue ? .transitionFlipFromTop : .transitionFlipFromBottom

		proficiencyCountLabel.text = String(selectionLimit - selectionsMade)

		if animated {
			UIView.transition(with: proficiencyCountLabel,
							  duration: 0.5,
							  options: animationDirection,
							  animations: { },
							  completion: nil)
		}

		if selectionsMade >= selectionLimit  {
				navigationItem.rightBarButtonItem?.isEnabled = true 	}
		else {	navigationItem.rightBarButtonItem?.isEnabled = false	}
	}
	func highlightProficiencyCountLabel() {
		let originalTextColor = proficiencyCountLabel.textColor
		UIView.transition(with: proficiencyCountLabel,
						  duration: 0.5,
						  options: [],
						  animations: {
							self.proficiencyCountLabel.textColor = .red
							self.proficiencyCountLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
							self.proficiencyCountLabel.font = UIFont.boldSystemFont(ofSize: 20)				},
						  completion: { _ in

		UIView.transition(with: self.proficiencyCountLabel,
						  duration: 0.5,
						  options: [],
						  animations: {
							self.proficiencyCountLabel.textColor = originalTextColor
							self.proficiencyCountLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
							self.proficiencyCountLabel.font = UIFont.systemFont(ofSize: 20)					},
						  completion: nil)
		})
	}
}

extension AbilitySelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionViewData.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath) as! SkillSelectionCollectionViewCell
		let data = collectionViewData[indexPath.row]

		cell.configure(with: data)

		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)! as! SkillSelectionCollectionViewCell

		//check if we are at or over the selection limit
		if selectedProficiencies.count >= Character.current.proficiencyChoiceCount() {
			print("over limit")
			collectionView.deselectItem(at: indexPath, animated: false)
			highlightProficiencyCountLabel()											}

		//this is a normal selection
		else {
			selectedProficiencies.append(collectionViewData[indexPath.row].name)
			updateProficiencyCountLabel(animated: true)
			cell.setProfienent(true, animated: true)
		}
	}
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)! as! SkillSelectionCollectionViewCell

		if let removeIndex = selectedProficiencies.firstIndex(of: collectionViewData[indexPath.row].name) {
			selectedProficiencies.remove(at: removeIndex)	}
		else { print("could not remove skill from proficiency list")}

		//update labels
		cell.setProfienent(false, animated: true)
		updateProficiencyCountLabel(animated: true)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.size.width * 0.30, height: 140)
	}

	private func registerCells() {
		collectionView.register(UINib(nibName: String(describing: SkillSelectionCollectionViewCell.self), bundle: nil),
								forCellWithReuseIdentifier: "SkillCell")
	}

	struct CollectionViewData {
		let name: String
		let source: ProficiencySource
		let value: Int
		let isSelectable: Bool
		var isSelected: Bool

		enum ProficiencySource {
			case background, `class`, none
		}
	}
	func loadCollectionViewData() -> [CollectionViewData] {
		var result = [CollectionViewData]()

		for skillName in skills {
			guard let skill = Skill(fromString: skillName)
				else { print("could not create skill enum from \(skillName) when creating SkillData"); continue }
			let modifier = Character.current.skillModifier(for: skill)

            if let background = Character.current.background {
				//if the proficiency is granted by the background already, prevent it from being selected
                if background.proficiencies.contains(skillName) {
					let data = CollectionViewData(name: skillName,
													source: .background,
													value: modifier,
													isSelectable: false,
													isSelected: true)
					result.append(data)
					continue
				}
			}
			//if the skill is available for the selected class
			if let classSkills = Character.current.class.skillSelection(),
				classSkills.contains(skillName) {

				let data = CollectionViewData(name: skillName,
												source: .class,
												value: modifier,
												isSelectable: true,
												isSelected: false)
				result.append(data)
				continue
			}
			//if the character has no path to this proficiency
			let data = CollectionViewData(name: skillName,
											source: .none,
											value: modifier,
											isSelectable: false,
											isSelected: false)
			result.append(data)
			continue
		}

		return result.sorted(by: { $0.name < $1.name })
	}
}

//Navigation
extension AbilitySelectionViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		Character.current.proficiencies.append(contentsOf: selectedProficiencies)
	}
}
