//
////  ExpandableTableViewCell.swift
////  CharacterCreator
////
////  Created by Ike Mattice on 7/24/18.
////  Copyright © 2018 Ike Mattice. All rights reserved.
////
//
//import UIKit
//
//class BackgroundSelectionTableViewCell: UITableViewCell {
//	@IBOutlet weak var titleLabel: UILabel!
//	@IBOutlet weak var subtitleLabel: UILabel!
//
//	@IBOutlet weak var proficienciesTitleLabel: UILabel!
//	@IBOutlet weak var proficiencyLabel: UILabel!
//
//	@IBOutlet weak var detailTitleLabel: UILabel!
//	@IBOutlet weak var detailLabel: UILabel!
//
//	@IBOutlet weak var itemTitleLabel: UILabel!
//	@IBOutlet weak var itemsLabel: UILabel!
//
//	@IBOutlet weak var dividerView: UIView!
//	@IBOutlet weak var backgroundImageView: UIImageView!
//
//
//
//	func configure(_ data: BackgroundSelectionViewController.TableViewData) {
//		titleLabel.text 				= data.title.capitalized
//		subtitleLabel.text				= data.expanded ? "" 									: data.reputationString().description
//
//		detailTitleLabel.text 			= data.expanded ? data.reputationString().title 		: ""
//		detailLabel.text 				= data.expanded ? data.reputationString().description	: ""
//
//		itemTitleLabel.text				= data.expanded ? "Starting Items"						: ""
//		itemsLabel.text					= data.expanded ? data.itemString()						: ""
//
//		proficienciesTitleLabel.text	= data.expanded ? "Innate Proficiencies"				: ""
//		proficiencyLabel.text			= data.expanded ? data.skillString()					: ""
//
//		dividerView.isHidden			= !data.expanded
//		backgroundImageView.isHidden	= data.expanded
//		backgroundImageView.image		= UIImage(named: data.title.lowercased())
//	}
//}
