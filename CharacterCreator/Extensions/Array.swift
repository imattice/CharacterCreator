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

	func duplicates() -> [Element] {
		var result: [Element] = [Element]()

		for item in self {
			let filtered = self.filter({ $0 == item })
			if filtered.count > 1 && !result.contains(item) {
				result.append(filtered.first!)
			}
		}

		return result
	}

	func duplicatesRemoved() -> [Element] {
		var result: [Element] = [Element]()

		for item in self {
			if result.contains(item) { continue }
			else { result.append(item)			}
		}

		return result	}
}
