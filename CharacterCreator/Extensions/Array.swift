//
//  Array.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/22/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}


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

extension Array {
    ///Return elements of a particular subclass that can be casted as the given type
    func ofType<T>(_ type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
