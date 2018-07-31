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

	func proficiencies() -> [String]? {
		guard let dict = backgroundData[name] as? [String: Any] else { print("could not initialize background data"); return nil }
		guard let skills = dict["skills"] as? [String] else { print("Could not get skills froom \(name)"); return nil }

		return skills
	}
}
