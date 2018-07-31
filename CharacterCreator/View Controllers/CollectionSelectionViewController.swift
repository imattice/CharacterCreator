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
	let collectionViewData = skills.sorted(by: { $0 < $1 } )

	let proficiencies = Character.default.background!.proficiencies()
	let availableSkills = Character.default.class!.skillSelection()

	let selectionLimit: Int = {
		if Character.default.class!.base == "rogue" {
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

		print(proficiencies!)
	}
}

extension CollectionSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionViewData.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath) as! SkillSelectionCollectionViewCell
		let cellSkill = collectionViewData[indexPath.row]

		cell.isUserInteractionEnabled = false

		//prevent user from deselecting background proficiencies
		if proficiencies!.contains(cellSkill) {
			cell.isSelected 				= true					}

		//enable skills that are in the class skill selection list
		if availableSkills!.contains(cellSkill) && !proficiencies!.contains(cellSkill) {
			cell.isAvailable 				= true
			cell.isUserInteractionEnabled 	= true 					}

		cell.titleLabel.text = cellSkill.capitalized
//		cell.modifierLabel.text = "\(modifier)"



		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)! as! SkillSelectionCollectionViewCell
		let cellSkill = collectionViewData[indexPath.row]

		//check if we are at or over the selection limit
		if selectionsMade >= selectionLimit {
			print("over limit")
			cell.isSelected = !cell.isSelected
			collectionView.deselectItem(at: indexPath, animated: false)
		}

		else {
			selectionsMade += 1
		}

		print("selections made: \(selectionsMade) /n selection limit: \(selectionLimit)")
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {


		//prevent selectionsMade counter from going into negative values
		if selectionsMade != 0 {
			selectionsMade -= 1 }

		print("selections made: \(selectionsMade) /n selection limit: \(selectionLimit)")
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
