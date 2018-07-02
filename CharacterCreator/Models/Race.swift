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
	let modifiers: [Modifier]

	init?(fromParent parentName: String, withSubrace subraceName: String?) {
		guard let parentData = raceData[parentName] as? [String : Any]
			else { print("invalid value \(parentName)"); return nil }

		var allModifiers = [Modifier]()

		//get subrace information
		if let subraceName = subraceName {
			guard let subraceArray = parentData["subraces"] as? [String: Any],
				let subraceData = subraceArray[subraceName] as? [String: Any]
				else { print("invalid value \(subraceName)"); return nil }

			//set the name to a subrace friendly name
			self.name = "\(subraceName.capitalized) \(parentName.capitalized)"

			//check for modifiers from the subrace
			if let modifiers = subraceData["modifiers"] as? [String: Int] {
				for modifierData in modifiers {
					allModifiers.append(Modifier(type: modifierData.key, value: modifierData.value, origin: .subrace))			}}}
		else {
			//set the name to just be the parent race if no subrace is available
			self.name = "\(parentName.capitalized)"  }

		//add modifiers from the parent race
		if let modifiers = parentData["modifiers"] as? [String : Int] {

			for modifierData in modifiers {
				allModifiers.append(Modifier(type: modifierData.key, value: modifierData.value, origin: .race))
			}
		}

		self.modifiers = allModifiers
	}
}
