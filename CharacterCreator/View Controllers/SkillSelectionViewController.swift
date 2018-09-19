//
//  CollectionSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class CollectionSelectionViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var proficiencyCountLabel: UILabel!
	let collectionViewData = skills.sorted(by: { $0 < $1 } )

	lazy var proficiencies: [String]? 	= Character.current.background!.proficiencies()
	lazy var availableSkills: [String]?	= Character.current.class!.skillSelection()

	var selectedProficiencies: [String] = [String]()

	let selectionLimit: Int = {
		if Character.current.class!.base == "rogue" {
			return 4 }
		else {
			return 2 }}()
	var selectionsMade: Int = 0 {
		didSet {
			if selectionsMade > selectionLimit {
				selectionsMade = selectionLimit }}}


	override func viewDidLoad() {
		super.viewDidLoad()

		collectionView.allowsMultipleSelection = true
		registerCells()

		updateProficiencyCountLabel(animated: false)

		navigationItem.rightBarButtonItem?.isEnabled = false
	}

	func updateProficiencyCountLabel(animated: Bool) {
		let currentValue = Int(proficiencyCountLabel.text!)!
		let nextValue = selectionLimit - selectionsMade
		let animationDirection: UIViewAnimationOptions = currentValue > nextValue ? .transitionFlipFromTop : .transitionFlipFromBottom

		proficiencyCountLabel.text = String(selectionLimit - selectionsMade)

		if animated {
			UIView.transition(with: proficiencyCountLabel,
							  duration: 0.5,
							  options: animationDirection,
							  animations: { },
							  completion: nil)
		}
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

extension CollectionSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionViewData.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath) as! SkillSelectionCollectionViewCell
		let cellSkill = collectionViewData[indexPath.row]

		//update the text labels
		cell.titleLabel.text = cellSkill.capitalized

		guard let skill = Skill(fromString: cellSkill) else { return cell }
		let modifier = Character.current.skillModifier(for: skill)
		cell.modifierLabel.text = "\(modifier)"


		//configure the interactions
		cell.isUserInteractionEnabled = false

		//automatically select background proficiencies
		if proficiencies!.contains(cellSkill) {
			cell.isSelected 				= true
			cell.updateModifierWithProficiency(animated: false)		}

		//enable skills that are in the class skill selection list
		if availableSkills!.contains(cellSkill) && !proficiencies!.contains(cellSkill) {
			cell.isAvailable 				= true
			cell.isUserInteractionEnabled 	= true 					}

		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)! as! SkillSelectionCollectionViewCell

		//check if we are at or over the selection limit
		if selectionsMade >= selectionLimit {
			print("over limit")
			cell.isSelected = !cell.isSelected
			collectionView.deselectItem(at: indexPath, animated: false)
			highlightProficiencyCountLabel()								}

		//this is a normal selection
		else {
//			guard let selectedProficiency = collectionViewData[indexPath.row] else { print("invalid selection.  Could not add proficiency."); return }
			selectedProficiencies.append(collectionViewData[indexPath.row])
			cell.updateModifierWithProficiency(animated: true)
			selectionsMade += 1
			updateProficiencyCountLabel(animated: true)
			if selectionsMade >= selectionLimit  {
				navigationItem.rightBarButtonItem?.isEnabled = true
			}
		}
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)! as! SkillSelectionCollectionViewCell

		if let removeIndex = selectedProficiencies.index(of: collectionViewData[indexPath.row]) {
			selectedProficiencies.remove(at: removeIndex)	}
		else { print("could not remove skill from proficiency list")}

		//prevent selectionsMade counter from going into negative values
		if selectionsMade != 0 {
			selectionsMade -= 1
			updateProficiencyCountLabel(animated: true) }

		cell.updateModifierWithProficiency(animated: true)

		if selectionsMade > 0 {
			navigationItem.rightBarButtonItem?.isEnabled = false
		}
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 115, height: 115)
	}

	private func registerCells() {
		collectionView.register(UINib(nibName: String(describing: SkillSelectionCollectionViewCell.self), bundle: nil),
								forCellWithReuseIdentifier: "SkillCell")
	}
}

//Navigation
extension CollectionSelectionViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		Character.current.proficiencies.append(contentsOf: selectedProficiencies)
	}
}
