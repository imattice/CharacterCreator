//
//  Array.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/22/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

extension Array where Element:Equatable {

	func hasDuplicates() -> Bool {
		for item in self {
			let filtered = self.filter( { $0 == item })
			if filtered.count > 1 {

				return true
			}
		}

		return false
	}

	func hasDuplicate(_ element: Element) -> Bool {
		return self.filter( { $0 == element }).count > 1
	}
}

extension Array where Element == String {
	func columnList(_ columns: Int) -> String{
		var result = ""
		let columnLineCount = self.count / columns
		var columnArray = [String]()

		for index in 0...columns {

		}

		return result
	}
}
