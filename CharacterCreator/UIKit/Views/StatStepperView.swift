////
////  StatStepperView.swift
////  CharacterCreator
////
////  Created by Ike Mattice on 6/20/18.
////  Copyright © 2018 Ike Mattice. All rights reserved.
////
//
//import UIKit
//
////@IBDesignable
//class StatStepperView: XibView {
//	var view: UIView!
//
//	@IBOutlet weak var statTitleLabel: UILabel!
//	@IBOutlet weak var statValueLabel: UILabel!
//	@IBOutlet weak var statStepper: UIStepper!
//
//	var delegate: StatViewDelegate?
//
//	var statArray = ["8", "10", "12", "13", "14", "15"]
//	var isFirstTap = true
//
//	//MARK: - View Lifecycle
////	required init?(coder aDecoder: NSCoder) {
////		super.init(coder: aDecoder)
////
////		xibSetup()
////	}
//
//	override func awakeFromNib() {
//		statStepper.autorepeat 		= true
//		statStepper.isContinuous 	= true
//		statStepper.wraps			= true
//		statStepper.maximumValue	= Double(statArray.count) - 1
//		statStepper.minimumValue	= 0
//	}
//
//
//	private func updateStatLabel() {
//		//prevent the first increase from skipping index 0
//		if isFirstTap && statStepper.value == 1.0 {
//			statStepper.value = 0.0
//			isFirstTap = false
//		}
//
//		statValueLabel.text = statArray[Int(statStepper.value)]
//	}
//
//	//MARK: - IBActions
//	@IBAction func stepperDidChange(_ sender: UIStepper) {
//		guard let prevText = statValueLabel.text  else {print("could not secure previous value"); return }
//
//		updateStatLabel()
//
//		guard let delegate = delegate else { print("delegate not set"); return }
//		guard let text = statValueLabel.text,
//			let newValue = Int(text) else { print("could not get a value from the stat stepper text"); return }
//
//		delegate.stepperDidChange((new: newValue, previous: Int(prevText)))
//	}
//}
