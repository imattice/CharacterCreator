//
//  Array.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/22/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//


//extension Array {
//	func containsDuplicate() -> Bool {
//		for item in self.enumerated() {
//			return self.filter( { $0 == item }).count > 1
//		}
//
//		return false
//	}
//}

extension Array where Element:Equatable {
//	func hasDuplicates() -> Bool {
//		for value in self {
//			if result.contains(value) == false {
//				result.append(value)
//			}
//		}
//
//		return result
//	}

	func hasDuplicates() -> Bool {
		for item in self {
			let filtered = self.filter( { $0 == item })
//			print("filtered: \(filtered)")
			if filtered.count > 1 {
//				print("full: \(self)")
//				print("duplicates found")
				return true
			}
		}
//		print("full: \(self)")
//		print("no duplicates")
		return false
	}

	func hasDuplicate(_ element: Element) -> Bool {
		return self.filter( { $0 == element }).count > 1
	}
}
