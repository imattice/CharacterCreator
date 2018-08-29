//
//  ChoiceContainerView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 8/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ChoiceSelectionView: UIView {
//	var view: UIView!

	@IBOutlet weak var scrollView: UIScrollView!
//	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var pageControl: UIPageControl!

	var choices: [String] = ["option1", "option2", "option3"]

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
//		xibSetup()

//		config()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
//		xibSetup()

//		config()
	}

//	private func config() {
//		scrollView.isPagingEnabled = true
//		scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(choices.count), height: 250)
//		scrollView.showsHorizontalScrollIndicator = false
//	}
//
//	private func loadChoices() {
//
//		for (index, choice) in choices.enumerated() {
//			guard let choiceView = Bundle.main.loadNibNamed("ChoiceView", owner: self, options: nil)?.first as? ChoiceView else { print("Could not load nib for \(choice)"); continue }
//			choiceView.titleLabel.text = choice
//
//			scrollView.addSubview(choiceView)
//
//			choiceView.frame.size.width = view.bounds.size.width
//			choiceView.frame.origin.x = CGFloat(index) * view.bounds.size.width
//		}
	}



//	func nextPage() {
//		guard let choices = choices else { print("no choices available for next page"); return }
//
//	}
//	func previousPage() {
//		guard let choices = choices else { print("no choices available for previous page"); return }
//
//
//	}
//}

extension ChoiceSelectionView: UIScrollViewDelegate {

//	enum ScrollDirection: Int {
//		case kScrollDirectionLeft = -1,
//			kScrollDirectionNone,
//			kScrollDirectionRight
//	}
//
//	func scrollEffectInDirection(direction: ScrollDirection) {
//		ContentView *previousPageView = (ContentView)[self.pageScrollView viewWithTag:kPreviousPageTag];
//		ContentView *currentPageView = (ContentView *)[self.pageScrollView viewWithTag:kCurrentPageTag];
//		ContentView *nextPageView = (ContentView *)[self.pageScrollView viewWithTag:kNextPageTag];
//
//	switch direction {
//		case kScrollDirectionNone:
//			[self fillPageView:currentPageView withPageNumber:self.currentPage.pageNumber];
//			[self fillPageView:previousPageView withPageNumber:self.currentPage.pageNumber - 1];
//			[self fillPageView:nextPageView withPageNumber:self.currentPage.pageNumber + 1];
//
//	case kScrollDirectionRight:{
//		// The previous page is free. Make it the next page.
//		CGRect previousPageViewRect = nextPageView.frame;
//		previousPageViewRect.origin.x += PAGE_WIDTH;
//		previousPageView.frame = previousPageViewRect;
//
//		// Fill the page.
//		[self fillPageView:previousPageView withPageNumber:self.currentPage.pageNumber + 1];
//
//	// Rearrange the page tag's.
//	nextPageView.tag = currentPageView.tag;
//	currentPageView.tag = previousPageView.tag;
//	previousPageView.tag = kNextPageTag;
//
//	// Update the page control.
//	[pageControl gotoNextPage];
//	}
//	break;
//
//	case kScrollDirectionLeft:{
//	// The next page is free. Make it the previous page.
//	CGRect nextPageViewRect = previousPageView.frame;
//	nextPageViewRect.origin.x -= PAGE_WIDTH;
//	nextPageView.frame = nextPageViewRect;
//
//	// Fill the page.
//	[self fillPageView:nextPageView withPageNumber:self.currentPage.pageNumber - 1];
//
//	// Rearrange the page tag's.
//	previousPageView.tag = currentPageView.tag;
//	currentPageView.tag = nextPageView.tag;
//	nextPageView.tag = kPreviousPageTag;
//
//	// Update the page control.
//	[pageControl gotoPreviousPage];
//	}
//	break;
//
//	default:
//	break;
//	}
//	[self inspectPageHighlightion];
//	}
//
//	-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
//	// Get the x of current page.
//	int currentPageX = (self.currentPage.pageNumber - 1) * PAGE_WIDTH;
//
//	if (self.pageScrollView.contentOffset.x >= currentPageX + PAGE_WIDTH) {
//	// User scrolled to right.
//	[self scrollEffectInDirection:kScrollDirectionRight];
//	}else if (self.pageScrollView.contentOffset.x <= currentPageX - PAGE_WIDTH) {
//	// User scrolled to left.
//	[self scrollEffectInDirection:kScrollDirectionLeft];
//	}
//	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
			print("right")
		}
		else { print("left")}
	}
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

	}
}
