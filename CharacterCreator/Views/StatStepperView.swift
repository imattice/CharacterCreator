//
//  StatStepperView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/20/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

@IBDesignable class StatStepperView: UIView {
	var view: UIView!

	@IBOutlet weak var statTitleLabel: UILabel!
	@IBOutlet weak var statValueLabel: UILabel!
	@IBOutlet weak var statStepper: UIStepper!

	let statArray = ["8", "10", "12", "13", "14", "15"]
	
	//MARK: - View Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)

		xibSetup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		xibSetup()
	}

	override func awakeFromNib() {
		backgroundColor = .white

		updateStatLabel()

		statStepper.autorepeat 		= true
		statStepper.isContinuous 	= true
		statStepper.wraps			= true
		statStepper.maximumValue	= Double(statArray.count) - 1
		statStepper.minimumValue	= 0
	}


	private func xibSetup() {
		view = loadViewFromNib()

		// use bounds not frame or it'll be offset
		view.frame = bounds

		// Make the view stretch with containing view
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

		// Adding custom subview on top of our view (over any custom drawing > see note below)
		addSubview(view)
	}

	private func loadViewFromNib() -> UIView {

		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

		return view
	}

	private func updateStatLabel() {
		statValueLabel.text = statArray[Int(statStepper.value)]
	}

	//MARK: - IBActions
	@IBAction func stepperDidChange(_ sender: UIStepper) {
//		print("stepper value: \(statStepper.value)")
		updateStatLabel()
	}
}
