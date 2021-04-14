////
////  SpellSelectionHeaderView.swift
////  CharacterCreator
////
////  Created by Ike Mattice on 7/13/18.
////  Copyright © 2018 Ike Mattice. All rights reserved.
////
//
//import UIKit
//
////TODO: We could move this xib file to the top of the view controller in the storyboard since we only need one instance of it!
//@IBDesignable
//class SpellSelectionHeaderView: XibView {
//	var view: UIView!
//
//	@IBOutlet var levelViews: [UIView]!
//	@IBOutlet weak var slotSlider: UIView!
//	@IBOutlet weak var spellbookCountContainer: UIView!
//	@IBOutlet weak var cantripCountContainer: UIView!
//	@IBOutlet weak var cantripCountLabel: UILabel!
//	@IBOutlet weak var spellbookCountLabel: UILabel!
//
//	@IBOutlet var spellSlotLabels: [UILabel]!
//	@IBOutlet weak var sliderLeftConstraint: NSLayoutConstraint!
//
//	override func config() {
//		configureSpellSlotLabels()
//		setUpSlider()
//	}
//
//	func shiftSlotSlider(toSection section: Int) {
//		let setColor = Character.current.class.gradient()
//
//		sliderLeftConstraint.constant	= slotSlider.frame.width * CGFloat(section)
//
//		UIView.animate(withDuration: 0.25) {
//			self.layoutIfNeeded()
//
//			guard section >= 0 else { return }
//
//			self.slotSlider.backgroundColor = setColor[section]
//		}
//	}
//
//	func highlight(countView view: CountView) {
//		let enabledColor = Character.current.class.color().lightColor()
//		let disabledColor = UIColor.white
//		let cornerRadius = CGFloat(5.0)
//		var enabledView: UIView { switch view {
//			case .spellbook: 	return spellbookCountContainer
//			case .cantrip: 		return cantripCountContainer			}}
//		var disabledView: UIView { switch view {
//			case .spellbook: 	return cantripCountContainer
//			case .cantrip: 		return spellbookCountContainer			}}
//
//		UIView.animate(withDuration: 0.25) {
//			enabledView.backgroundColor = enabledColor
//			enabledView.layer.cornerRadius = cornerRadius
//
//			disabledView.backgroundColor	= disabledColor
//			disabledView.layer.cornerRadius = 0
//		}
//	}
//
//	enum CountView {
//		case cantrip, spellbook
//	}
//
//
//	private func setUpSlider() {
//		slotSlider.backgroundColor 	= Character.current.class.color().lightColor()
//		slotSlider.alpha			= 0.5
//		shiftSlotSlider(toSection: 0)
//
////		countSlider.backgroundColor		= Character.default.class.color().lightColor()
////		countSlider.alpha				= 0.5
//	}
//	private func configureSpellSlotLabels() {
//		guard let castingAttributes = Character.current.class.castingAttributes else { print("could not label slots"); return }
//
//		for (index, label) in spellSlotLabels.enumerated() {
//			let spellLevel = index + 1
//			if let slotCount = castingAttributes.spellSlots.filter({ $0.SpellLevel == spellLevel }).first {
//				label.text = String(slotCount.SpellLevel)													}
//			else {
//				label.text = "-" 	}
//		}
//	}
//}
