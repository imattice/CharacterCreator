//
//  WeaponStatView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/1/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable
class WeaponStatView: XibView {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var attackBonusLabel: UILabel!
	@IBOutlet weak var damageRollLabel: UILabel!
	@IBOutlet weak var damageTypeLabel: UILabel!

	var weapon: Weapon? {
		didSet {
			config()	}}

	override func config() {
		guard let weapon = weapon else { return }
		nameLabel.text				= weapon.name
		attackBonusLabel.text		= "+5"
		damageRollLabel.text		= weapon.damage.rollString(withType: false)
		damageTypeLabel.text		= weapon.damage.type.rawValue
	}
}
