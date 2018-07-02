//
//  ClassDetailViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

protocol ClassDetail {
	var targetClass: String { get }
	var selectedClass: Class { get set }
}

class ClassDetailViewController: UIViewController {
	@IBOutlet weak var headerView: ClassHeaderView!


	var targetClass: String? 	= "rogue"
	var selectedClass: Class? 	= nil

    override func viewDidLoad() {
        super.viewDidLoad()

		selectedClass = getData()

		guard let selectedClass = selectedClass else { print("Could not load selected class for \(targetClass!)"); return }

		headerView.titleLabel.text			= selectedClass.name.capitalized
		headerView.iconImageView.image		= UIImage(named: selectedClass.name.lowercased())
		headerView.hitDieLabel.text			= String(selectedClass.hitDie)
    }

	private func getData() -> Class? {
		guard let targetClass = targetClass,
			let classDict = classData[targetClass] as? [String : Any],
			let hitDieData = classDict[ClassKey.hitDie.rawValue] as? String,
			let hitDie = Int(hitDieData) else {print("Could not fetch data for the class \(self.targetClass!)"); return nil }




		return Class(name: targetClass, hitDie: hitDie)
	}
}
