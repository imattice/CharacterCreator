//
//  UIView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit


//extension UIView {
//	func setTextColor() {
//		guard let backgroundColor = backgroundColor else { return }
//
//		for view in subviews {
//		guard let label = view as? UILabel  else { continue }
//			if backgroundColor.isDark {
//				label.textColor = .lightText		}
//			else {
//				label.textColor = .darkText			}
//		}
//	}
//}
//
//class XibView: UIView {
//
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		self.xibSetup()
//
//		config()
//	}
//	required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//		self.xibSetup()
//
//		config()
//	}
//
//	func config() {	}
//
//	func xibSetup() {
//		let view = loadViewFromNib()
//
//		// use bounds not frame or it'll be offset
//		view.frame = bounds
//
//		// Make the view stretch with containing view
//		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//		// Adding custom subview on top of our view (over any custom drawing > see note below)
//		addSubview(view)
//	}
//
//	private func loadViewFromNib() -> UIView {
//
//		let bundle = Bundle(for: type(of: self))
//		let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
//		let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
//
//		return view
//	}
//
//	class func fromNib<T: UIView>() -> T {
//		return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)!.first! as! T
//	}
//
//}
