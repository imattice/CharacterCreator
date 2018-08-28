//
//  ChoiceSelectionViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ChoiceSelectionViewController: UIViewController {
	@IBOutlet weak var stackView: UIStackView!

	var choiceData = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

		getClassChoices()

		for choice in choiceData.enumerated() {
			let container = ChoiceSelectionView()
				container.backgroundColor = .red

			stackView.addArrangedSubview(container)


			container.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint(item: container,
							   attribute: .leading,
							   relatedBy: .equal,
							   toItem: stackView,
							   attribute: .leading,
							   multiplier: 1,
							   constant: 0).isActive = true
			NSLayoutConstraint(item: container,
							   attribute: .trailing,
							   relatedBy: .equal,
							   toItem: stackView,
							   attribute: .trailing,
							   multiplier: 1,
							   constant: 0).isActive = true
			NSLayoutConstraint(item: container,
							   attribute: .height,
							   relatedBy: .equal,
							   toItem: nil,
							   attribute: .height,
							   multiplier: 1,
							   constant: 300).isActive = true
//			NSLayoutConstraint(item: container,
//							   attribute: .width,
//							   relatedBy: .equal,
//							   toItem: nil,
//							   attribute: .width,
//							   multiplier: 1,
//							   constant: view.bounds.width).isActive = true

			for option in choice.element {
				let optionView = ChoiceView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
					optionView.titleLabel.text = option
					optionView.backgroundColor = .red

				addToStack(atIndex: choice.offset, optionView)
			}
		}
	}

	private func addToStack(atIndex index: Int, _ choiceView: UIView) {
		guard index <= stackView.arrangedSubviews.count else { print("placement index out of range"); return }

		for containerViews in stackView.arrangedSubviews.enumerated() {
			if containerViews.offset == index {
				//ensure the view is a container view
				guard let containerView = containerViews.element as? ChoiceSelectionView else { continue }
				containerView.stackView.addArrangedSubview(choiceView)

				choiceView.translatesAutoresizingMaskIntoConstraints = false
				NSLayoutConstraint(item: choiceView,
								   attribute: .height,
								   relatedBy: .equal,
								   toItem: nil,
								   attribute: .height,
								   multiplier: 1,
								   constant: 200).isActive = true
				NSLayoutConstraint(item: choiceView,
								   attribute: .width,
								   relatedBy: .equal,
								   toItem: nil,
								   attribute: .width,
								   multiplier: 1,
								   constant: 500).isActive = true


			}
		}

	}

	func getClassChoices() {
		guard let classDict = classData["cleric"] as? [String : Any],
			let equiptmentChoices = classDict["equipment"] as? [[String]]  else { print("Could not initialize race equiptment data"); return }

		choiceData = equiptmentChoices
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
