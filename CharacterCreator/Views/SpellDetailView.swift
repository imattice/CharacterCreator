//
//  SpellDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/6/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

protocol SpellDetailDelegate {
	func addToSpellbook(_ spell: Spell)
	func didCancelSelection(of spell: Spell)
}

class SpellDetailView: UIView {
	@IBOutlet weak var backgroundView: UIView!
	@IBOutlet weak var detailView: UIView!

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var rangeLabel: UILabel!
	@IBOutlet weak var castTimeLabel: UILabel!
	@IBOutlet weak var durationLabel: UILabel!
	@IBOutlet weak var damageLabel: UILabel!
	@IBOutlet weak var shapeLabel: UILabel!
	@IBOutlet weak var targetLabel: UILabel!
	@IBOutlet weak var componentLabel: UILabel!

	@IBOutlet weak var shapeImageView: UIImageView!
	@IBOutlet weak var targetImageView: UIImageView!

	@IBOutlet weak var shapeView: UIView!
	@IBOutlet weak var targetView: UIView!

	var spell: Spell? { didSet { configure() }}
	var delegate: SpellDetailDelegate?

	static func view(for spell: Spell) -> SpellDetailView {
		let view: SpellDetailView = .fromNib()
		view.spell = spell
		view.configure()

		view.detailView.layer.cornerRadius 	= CGFloat(15.0)

		return view
	}


	private func configure() {
		guard let spell = spell else { return }
		titleLabel.text 			= spell.name.capitalized
		levelLabel.text				= { spell.isCantrip() ? "Cantrip" : "Level \(spell.level)" }()
		descriptionLabel.text		= spell.description()

		rangeLabel.text				= spell.range.capitalized
		castTimeLabel.text			= spell.castTime.capitalized
		durationLabel.text			= spell.duration.capitalized

		if let damage = spell.damage {
			damageLabel.text			= damage 	}
		else { damageLabel.text			= "-"			}

		var componentString = ""
		if spell.components.contains("v") { componentString += "• Verbal "				}
		if spell.components.contains("s") { componentString += "• Somatic "				}
		if spell.components.contains("m") { componentString += "• Material "
											componentString += "•\n(\(spell.materials!.capitalized))"	}
		else {								componentString += "•"						}
		componentLabel.text			= componentString

		if let shape = spell.shape {
			shapeImageView.image		= UIImage(named: shape.shape.rawValue)
			shapeLabel.text				= shape.size	}
		else { shapeView.removeFromSuperview() }

		if let target = spell.target {
			var text = ""
			if target.count == .all {
				text = "all objects in area"			}
			else {
				text = "up to \(target.count) target"
				if target.count != .one {
					text.append("s")	}
			}

			targetImageView.image		= UIImage(named: target.count.rawValue)
			targetLabel.text			= text
		} else { targetView.removeFromSuperview() }

	}

	@IBAction func add(_ sender: UIButton) {
		guard let delegate = delegate,
			let spell = spell
			else { print("failed to add \(String(describing: self.spell?.name)) to spellbook"); disappear(true); return }
		delegate.addToSpellbook(spell)
		disappear(true)
	}

	@IBAction func close(_ sender: UIButton) {
		guard let delegate = delegate,
			let spell = spell
			else { print("failed to cancel \(String(describing: self.spell?.name)) selection"); disappear(true); return }
		delegate.didCancelSelection(of: spell)
		disappear(true)
	}

	func hide() {
		self.isHidden = true
	}

	func appear(_ animated: Bool) {
		self.alpha			= 0.0

		if animated {
			self.isHidden = false

			UIView.animate(withDuration: 0.25,
						   animations: {
							self.alpha		= 1.0
			})
		}
	}
	func disappear(_ animated: Bool) {
		self.alpha			= 1.0

		if animated {
			UIView.animate(withDuration: 5,
						   animations: {
							self.alpha		= 0.0
			})
		}
		self.removeFromSuperview()
	}
}
