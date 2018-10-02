//
//  Background.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation


struct Background {
	let name: String

	init(_ name: String) {
		self.name = name
	}

	func proficiencies() -> [String]? {
		guard let dict = backgroundData[name] as? [String: Any] else { print("could not initialize background data"); return nil }
		guard let skills = dict["skills"] as? [String] else { print("Could not get skills froom \(name)"); return nil }

		return skills
	}
	func description() -> String {
		guard let backgroundDict = backgroundData[name] as? [String : Any],
			let reputationDict = backgroundDict["reputation"] as? [String : String],
			let description = reputationDict.values.first
		else { print("could not initialize data for background \(name)"); return "" }

		return description
	}
}
