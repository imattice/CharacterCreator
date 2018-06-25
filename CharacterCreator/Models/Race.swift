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
//	let description: String?
	let modifiers: [Modifier]
}
