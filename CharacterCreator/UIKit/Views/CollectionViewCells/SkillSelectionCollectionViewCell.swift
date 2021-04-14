////
////  SkillSelectionCollectionViewCell.swift
////  CharacterCreator
////
////  Created by Ike Mattice on 7/27/18.
////  Copyright © 2018 Ike Mattice. All rights reserved.
////
//
//import UIKit
//
//class SkillSelectionCollectionViewCell: UICollectionViewCell {
//	@IBOutlet weak var proficiencyLabel: UILabel!
//	@IBOutlet weak var titleLabel: UILabel!
//	@IBOutlet weak var modifierLabel: UILabel!
//	@IBOutlet weak var sourceLabel: UILabel!
//
//	@IBOutlet var animatedConstraints: [NSLayoutConstraint]!
//	@IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
//
//	override var isSelected: Bool { didSet { setBackground() }}
//	var isAvailable: Bool = false { didSet { setBackground() }}
//
//
//
//	override func awakeFromNib() {
//		super.awakeFromNib()
//
//		contentView.layer.borderWidth 		= 3
//		contentView.layer.borderColor 		= UIColor.black.cgColor
//		contentView.layer.cornerRadius		= 5.0
//
//		setBackground()
//	}
//
//	func configure(with data: AbilitySelectionViewController.CollectionViewData) {
//		var sourceText: String {
//			switch data.source {
//			case .background:	return "Learned as \(Character.current.background!.name.capitalized)"
//			case .class:		return "Potential for \(Character.current.class.base.capitalized)s"
//			case .none:			return "Unavailable to \(Character.current.class.base.capitalized)s"
//			}
//		}
//
//		//update the text labels
//		titleLabel.text 		= data.name.capitalized
//		modifierLabel.text 		= "\(data.value)"
//		sourceLabel.text		= sourceText
//		proficiencyLabel.text	= ""
//
//		isAvailable				= data.isSelectable
//
//		//automatically select background proficiencies
//		if data.isSelected {
//			setProfienent(true, animated: false) 				}
//
//		//configure the unavailable cells
//		if !data.isSelectable {
//			let disabledTextColor		= UIColor.gray
//			isUserInteractionEnabled	= false
//			modifierLabel.textColor		= disabledTextColor		}
//
//		setBackground()
//	}
//
//	func setProfienent(_ isProficient: Bool, animated: Bool) {
//		setBackground(animated: animated)
//
//		updateModifierLabel(isProficient, animated: animated)
//		updateProficientLabel(isProficient, animated: animated)
//
//		isSelected = isProficient
//	}
//
//	private func setBackground(animated: Bool = false) {
//		var backgroundColor: UIColor = .lightGray
//
//		if isAvailable {
//			backgroundColor = Character.current.class.color().lightColor()
//		}
//		if isSelected {
//			backgroundColor = Character.current.class.color().base()
//		}
//
//		if animated {
//			UIView.transition(with: contentView,
//							  duration: 0.25,
//							  options: .transitionCrossDissolve,
//							  animations: {
//								self.contentView.backgroundColor = backgroundColor
//
//								self.contentView.setTextColor()						},
//							  completion: nil)}
//		else {
//			contentView.backgroundColor = backgroundColor
//			contentView.setTextColor()												}
//	}
//
//	private func updateModifierLabel(to value: Int, animated: Bool) {
//		modifierLabel.text  = String(value)
//
//		if animated {
//			UIView.transition(with: modifierLabel,
//							  duration: 0.5,
//							  options: [.curveEaseIn, .transitionFlipFromTop],
//							  animations: { },
//							  completion:  nil)
//		}
//	}
//
//	private func updateProficientLabel(_ isProficient: Bool, animated: Bool = false) {
//		let heightConstraint = animatedConstraints.filter( { $0.identifier == "titleTopConstraint" } ).first
//		let proficiencyText: String				= { isProficient ? "PROFICIENT IN" 	: ""  }()
//		let heightConstraintConstant: CGFloat 	= { isProficient ? 17.0 			: 5.0 }()
//
//		proficiencyLabel.text		= proficiencyText
//		heightConstraint?.constant 	= heightConstraintConstant
//
//		if animated {
//			UIView.animate(withDuration: 0.5, animations: { self.layoutIfNeeded() })  }
//	}
//	private func updateModifierLabel(_ isProficient: Bool, animated: Bool = false) {
//		guard let text = modifierLabel.text,
//			let currentValue = Int(text)
//			else { print("could not convert label text to int"); return }
//		let proficiencyBonus 	= Character.current.proficiencyBonus
//		let newValue: Int 		= { isProficient ? currentValue + proficiencyBonus 	: currentValue - proficiencyBonus }()
//		let labelText: String 	= { newValue > 0 ? "+\(newValue)" 					: String(newValue) }()
//
//		modifierLabel.text  = labelText
//
//		if animated {
//			UIView.transition(with: modifierLabel,
//							  duration: 0.5,
//							  options: [.curveEaseIn, .transitionFlipFromTop],
//							  animations: { },
//							  completion:  nil)
//		}
//	}
//}
