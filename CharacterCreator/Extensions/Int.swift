//
//  Int.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/23/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import CoreGraphics

postfix operator °

protocol IntegerInitializable: ExpressibleByIntegerLiteral {
	init (_: Int)
}

extension Int: IntegerInitializable {
	postfix public static func °(lhs: Int) -> CGFloat {
		return CGFloat(lhs) * .pi / 180
	}
}
