//
//  FlavorViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/3/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//


//Social - Name, Age, Alignment, Personality, Height, Build/Weight, Eye Color
//Appearance - clothes, distint markings or features,
//Purpose - Ideals, Bonds, Flaws
//Histroy - Languages, Faction, Backstory


import UIKit

class FlavorViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageControl: UIPageControl!

	@IBOutlet weak var identityFlavorView: IdentityFlavorView!
	@IBOutlet var flavorViews: [UIView]!

	let colors: [UIColor] = [.red, .yellow, .green, .blue]


	override func viewDidLoad() {
        super.viewDidLoad()
		addViews()

		configureScrollView()

		scrollView.addSubview(identityFlavorView)



        // Do any additional setup after loading the view.
    }

	private func configureScrollView() {
		scrollView.delegate 						= self
		scrollView.isPagingEnabled 					= true
		scrollView.contentSize 						= CGSize(width: view.frame.width,
																height: view.frame.height * CGFloat(flavorViews.count))
		scrollView.showsVerticalScrollIndicator	 	= false
		scrollView.alwaysBounceVertical 			= false
		scrollView.isDirectionalLockEnabled 		= true
		scrollView.bounces							= false


		pageControl.numberOfPages = flavorViews.count
		pageControl.transform = CGAffineTransform(rotationAngle: 90°)
	}
	private func addViews() {
		for (index, flavorView) in flavorViews.enumerated() {

			scrollView.addSubview(flavorView)

			flavorView.frame.size.height 	= self.view.frame.size.height - 40
			flavorView.frame.origin.y		= CGFloat(index) * self.view.bounds.size.height

			flavorView.backgroundColor = colors[index]
		}
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

extension FlavorViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		//prevent horizontal scrolls
		if scrollView.contentOffset.x != 0 {
			scrollView.contentOffset.x = 0 }

		let pageIndex = scrollView.contentOffset.y / scrollView.frame.size.height
		pageControl.currentPage = Int(pageIndex)
	}
}
