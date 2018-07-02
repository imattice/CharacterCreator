//
//  Class.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

struct Class {
	let name: String
	let hitDie: Int

	init?(fromString className: String, withPath pathName: String) {
		guard let parentData 	= classData[className] as? [String : Any],
			let hitDie			= parentData["hit_die"] as? Int,
			let pathsArray 		= parentData["paths"] as? [String: Any],
			let pathData 		= pathsArray[pathName] as? [String: Any]
			else { print("could not populate data for: \(pathName) \(className)"); return nil }

			//set the name to a subrace friendly name
			self.name 	= "\(pathName.capitalized) \(className.capitalized)"
			self.hitDie = hitDie

	}
}
