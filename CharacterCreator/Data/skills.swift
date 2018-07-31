//
//  skills.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

let skills = [
	//Strength
	"athletics",

	//Dexterity
	"acrobatics",
	"slight of hand",
	"stealth",

	//Charisma
	"deception",
	"intimidation",
	"performance",
	"persuasion",

	//Intelligence
	"arcana",
	"history",
	"investigation",
	"nature",
	"religion",

	//Wisdom
	"animal handling",
	"insight",
	"medicine",
	"perception",
	"survival"
]

import UIKit

enum Skill: String {
	case athletics,

	acrobatics,
	slightOfHand,
	stealth,

	deception,
	intimidation,
	performance,
	persuasion,

	arcana,
	history,
	investigation,
	nature,
	religion,

	animalHandling,
	insight,
	medicine,
	perception,
	survival

	init(rawValue: String) {
		if rawValue == "animal handling" {
			self.init(rawValue: "animalHandling") 	}
		else if rawValue == "slight of hand" {
			self.init(rawValue: "slightOfHand") 	}
		else {
			self.init(rawValue: rawValue)			}
	}

	func colors() -> [UIColor] {
		switch self {
		case .athletics:
			return UIColor.MaterialColor.redGradientColors

		case .acrobatics, .slightOfHand, .stealth:
			return UIColor.MaterialColor.greenGradientColors

		case .arcana, .history, .investigation, .nature, .religion:
			return UIColor.MaterialColor.purpleGradientColors

		case .animalHandling, .insight, .medicine, .perception, .survival:
			return UIColor.MaterialColor.blueGradientColors

		case .deception, .intimidation, .performance, .persuasion:
			return UIColor.MaterialColor.yellowGradientColors
		}
	}
}
