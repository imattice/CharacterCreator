//
//  ParentTableViewCell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/23/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var cornerButton: UIButton!

	var buttonColor: UIColor?
	var highlightColor: UIColor?
	var buttonAction: Selector?

	func removeImageView() {
		imageView?.removeFromSuperview()

		titleLabel.constraints.filter({ $0.identifier == "leading" }).first?.isActive = false
		descriptionLabel.constraints.filter({ $0.identifier == "leading" }).first?.isActive = false

		NSLayoutConstraint(item: descriptionLabel,
						   attribute: .leading,
						   relatedBy: .equal,
						   toItem: contentView,
						   attribute: .leading,
						   multiplier: 1,
						   constant: 80).isActive = true
		NSLayoutConstraint(item: titleLabel,
						   attribute: .leading,
						   relatedBy: .equal,
						   toItem: contentView,
						   attribute: .leading,
						   multiplier: 1,
						   constant: 80).isActive = true

		updateConstraints()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		if selected {
		guard let highlightColor = highlightColor, let buttonColor = buttonColor else { return }
		UIView.transition(with: contentView,
						  duration: 0.25,
						  options: .transitionCrossDissolve,
						  animations: {
							self.contentView.backgroundColor = highlightColor
							self.cornerButton.setTitleColor(buttonColor, for: .normal)
							},
						  completion: nil)
		} else {
			UIView.transition(with: contentView,
							  duration: 0.25,
							  options: .transitionCrossDissolve,
							  animations: {
								self.contentView.backgroundColor = .white
			},
							  completion: nil)
		}
	}

	func configure(forDataType dataType: String, withData data: DropdownCellData, at indexPath: IndexPath) {

		//configure parent cells
		if indexPath.row == 0 {
			let cellData = data.parentData

			//reset dequeued cells
			 accessoryView 					= nil
			 selectionStyle 				= .default

			//finish the label configuration
			 titleLabel.text 				= cellData.title.capitalized
			 iconImageView.image 			= UIImage(named: cellData.title.lowercased())
			 descriptionLabel.text 			= cellData.description

			if dataType == "race" {
				//make the button look like a label
				 cornerButton.setTitleColor(.black, for: .normal)
				 cornerButton.isUserInteractionEnabled		= false

				 cornerButton.setTitle(Race.modifierString(for: cellData.title, withSubrace: nil), for: .normal )
			}

			if dataType == "class" {
				//remove the corner button for parent classes
				 cornerButton.isHidden 		= true
			}
		}


		//configure child cells
		else {
			guard let cData = data.childData
				else { print("could not initialize subrace cell from data"); return }
			let parentData = data.parentData
			let childData = cData[indexPath.row - 1]

			if dataType == "race" {

				 titleLabel.text 				= childData.title.capitalized
				 descriptionLabel.text 			= childData.description

				cornerButton.setTitleColor(.black, for: .normal)
				cornerButton.isUserInteractionEnabled		= false

				cornerButton.setTitle(Race.modifierString(for: parentData.title, withSubrace: childData.title), for: .normal )
			}


			if dataType == "class" {

				 titleLabel.text 				= childData.title.capitalized
				 descriptionLabel.text 			= childData.description

				 cornerButton.setTitle("Advanced Level Features", for: .normal)
				 cornerButton.tintColor = UIColor.color(for: AvailableClass(rawValue: parentData.title.lowercased())!).base()

				if let parentClass = AvailableClass(rawValue: parentData.title.lowercased()) {
					highlightColor = UIColor.color(for: parentClass).lightColor()
					buttonColor = UIColor.color(for: parentClass).darkColor()
				} else { print("no highlight color")}


				if  imageView?.image == nil {
					 removeImageView()
				}
			}
		}
	}
}
