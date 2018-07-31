//  backgrounds.swift
//
//
//  Created by Ike Mattice on 7/23/18.
//

let backgroundData: [String : Any] = [
	"acolyte": [
		"skills": ["insight", "religion"],
		"languages": ["choice", "choice"],
		"clothes": "common",
		"coin": "15",
		"equipment": ["A holy symbol", "a prayer book", "5 sticks of incense", "vestments", "a set of common clothes", "coin pouch (15gp)"],
		"reputation": [
			"Shelter of the Failthful": "Living a life devoted to the temple of your diety, you can expect to be welcomed and granted shelter within any community that shares your beliefs.  The servants there will gladly heal your wounds and support you where they can." ],
		"description" : "" ],
	"criminal": [
		"skills": ["deception", "stealth"],
		"tools": ["gaming", "thieves"],
		"clothes": "dark",
		"coin": "15",
		"equipment": ["A crowbar", "a set of hooded, dark clothes", "coin pouch (15gp)"],
		"specialty": ["Blackmailer", "Burgler", "Enforcer", "Fence", "Highway Robber", "Hired Killer", "Pickpocket", "Smuggler"],
		"reputation": [
			"Criminal Contact": "Your primary contact can serve as a liason to other criminals and organizations that may find your skills... useful.  Using this network of messagers, you can quickly get your words accross great distances. " ],
		"description": "" ],
	"folk hero": [
		"skills": ["animal handling", "survival"],
		"tools": ["artisan's tools", "land vehicles"],
		"clothes": "common",
		"coin": "10",
		"equipment": ["artisan's tools", "a shovel", "an iron pot", "a set of common clothes", "coin pouch (10gp)"],
		"reputation": [
			"Rustic Hospitality": "The peasants are your people and you are known to offer what help you can.  In return, common folk are willing to reciprocate that aid, granting you food, water, shelter - even a place to hide, if needed." ],
		"description" : "" ],
	"noble": [
		"skills": ["history", "persuasion"],
		"tools": ["gaming"],
		"languages": ["choice"],
		"clothes": "fine",
		"coin": "25",
		"equipment": ["a signet ring", "a scroll of pedigree" ],
		"reputation": [
			"Position of Privilege": "You carry yourself with honor and wealth - people know you you are wherever you go.  In an effort to stay in your good graces, people will bend to your will easily and assume that you are in the right place.  Using your status, you can even request to meet with the important people of the locale." ],
		"description" : "" ],
	"sage": [
		"skills": ["arcana", "history"],
		"languages": ["choice", "choice"],
		"clothes": "common",
		"coin": "10",
		"equipment": ["a bottle of black ink", "a quill", "a small knife", "a inquisitive letter"],
		"specialty": ["Alchemist", "Astronomer", "Discredited Academic", "Librarian", "Professor", "Researcher", "Wizard's Apprentice", "Scribe"],
		"reputation": [
			"Researcher": "Your familiarity with finding knowledge gives you an edge when looking for a specific piece of information.  You know how to request access to repositories of knowledge, such as libraries, universities, or other well-read individuals." ],
		"description" : "" ],
	"soldier": [
		"skills": ["athletics", "intimidatation"],
		"tools": ["gaming", "land vehicles"],
		"clothes": "common",
		"coin": "10",
		"equipment": ["an insignia of rank", "a trophy", "a deck of cards or dice"],
		"specialty": ["Officer", "Scout", "Infantry", "Cavalry", "Healer", "Quatermaster", "Standard Bearer", "Support Staff"],
		"reputation": [
			"Researcher": "You come from a world of order and dicipline.  Other militant leaders recognize your status and accomplishments, and you can impose your influance on any other soldier of a lower rank.  You can usually find respite at a friendly military barracks or encampment." ],
		"description" : "" ],
]

enum backgrounds: String {
	case 	Acolyte,
	Criminal,
	FolkHero,
	Noble,
	Sage,
	Soldier
}
