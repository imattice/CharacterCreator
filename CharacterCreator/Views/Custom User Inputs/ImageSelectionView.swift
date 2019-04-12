//
//  ImageSelectionView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/4/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit

protocol ImageSelectionDelegate {
	func selectImage()
}
@IBDesignable
class ImageSelectionView: UIView {
	let imageView = UIImageView()

	@IBOutlet var delegate: UIImagePickerControllerDelegate?

	@IBInspectable var image: UIImage? {
		didSet {
			imageView.image = image		}}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		config()
	}
	override init(frame: CGRect) {
		super.init(frame: frame)

		config()
	}

	private func config() {
		imageView.contentMode = .scaleAspectFit

		addSubview(imageView)

		layoutViews()

	}

	private func layoutViews() {

		let viewDict = ["imageView"		: imageView,
						"self"			: self ]

		imageView.translatesAutoresizingMaskIntoConstraints = false
		let H_imageView = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[imageView(>=75)]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)
		let V_imageView = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[imageView(>=75)]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDict)

		let constraints = H_imageView + V_imageView

		self.addConstraints(constraints)
	}
}

