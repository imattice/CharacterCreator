//
//  ChoiceContainerView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ChoiceSelectionView: UIView {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!

	var choices: [String] = ["option1", "option2", "option3"] {
		didSet {
			config()
			addChoiceViews() } }
	var presentedChoice: String? = nil

	private func config() {
		scrollView.delegate = self
		scrollView.isPagingEnabled = true
		scrollView.contentSize = CGSize(width: self.bounds.width * CGFloat(choices.count), height: 250)
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.alwaysBounceHorizontal = false

		pageControl.numberOfPages = choices.count
	}

	private func addChoiceViews() {

		for (index, choice) in choices.enumerated() {
			guard let choiceView = Bundle.main.loadNibNamed("ChoiceView", owner: self, options: nil)?.first as? ChoiceView else { print("Could not load nib for \(choice)"); continue }
			choiceView.titleLabel.text = choice

			scrollView.addSubview(choiceView)

			choiceView.frame.size.width 	= self.bounds.size.width
			choiceView.frame.origin.x 		= CGFloat(index) * self.bounds.size.width
		}
	}

}

extension ChoiceSelectionView: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
		pageControl.currentPage = Int(pageIndex)
	}
}
