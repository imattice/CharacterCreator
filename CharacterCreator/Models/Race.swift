//
//  Race.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

typealias Subrace = Race

struct Race {
	let name: String
	let subrace: String?
	let modifiers: [Modifier]

	func modifierString() -> String {
		var result: String = ""
		for modifier in modifiers {
			result += "+ \(modifier.type.capitalized)  "
		}

		return result.replacingOccurrences(of: "_", with: " ").trimmingCharacters(in: .whitespaces)
	}
}
