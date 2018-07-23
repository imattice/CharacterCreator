//
//  backgroundData.swift
//  
//
//  Created by Ike Mattice on 7/23/18.
//

let backgroundData: [String : Any] = [
	"Acolyte": [
		"skills": ["Insight", "Religion"],
		"languages": ["choice", "choice"],
		"clothes": "common",
		"coin": "15",
		"equipment": ["A holy symbol", "a prayer book", "5 sticks of incense", "vestments", "a set of common clothes", "coin pouch (15gp)"],
		"feature": [
			"Shelter of the Failthful": "" ],
		"description" : "" ],
	"Criminal": [
		"skills": ["Deception", "Stealth"],
		"tools": ["gaming", "thieves"],
		"clothes": "dark",
		"coin": "15",
		"equipment": ["A crowbar", "a set of hooded, dark clothes", "coin pouch (15gp)"],
		"specialty": ["Blackmailer", "Burgler", "Enforcer", "Fence", "Highway Robber", "Hired Killer", "Pickpocket", "Smuggler"],
		"feature": [
			"Criminal Contact": "" ],
		"description": "" ],
	"Folk Hero": [
		"skills": ["Animal Handling", "Survival"],
		"tools": ["artisan's tools", "land vehicles"],
		"clothes": "common",
		"coin": "10",
		"equipment": ["artisan's tools", "a shovel", "an iron pot", "a set of common clothes", "coin pouch (10gp)"],
		"feature": [
			"Rustic Hospitality": "" ],
		"description" : "" ],
	"Noble": [
		"skills": ["History", "Persuasion"],
		"tools": ["gaming"],
		"languages": ["choice"],
		"clothes": "fine",
		"coin": "25",
		"equipment": ["a signet ring", "a scroll of pedigree" ],
		"feature": [
			"Position of Privilege": "" ],
		"description" : "" ],
	"Sage": [
		"skills": ["Arcana", "History"],
		"languages": ["choice", "choice"],
		"clothes": "common",
		"coin": "10",
		"equipment": ["a bottle of black ink", "a quill", "a small knife", "a inquisitive letter"],
		"specialty": ["Alchemist", "Astronomer", "Discredited Academic", "Librarian", "Professor", "Researcher", "Wizard's Apprentice", "Scribe"],
		"feature": [
			"Researcher": "" ],
		"description" : "" ],
	"Soldier": [
		"skills": ["Athletics", "Intimidatation"],
		"tools": ["gaming", "land vehicles"],
		"clothes": "common",
		"coin": "10",
		"equipment": ["an insignia of rank", "a trophy", "a deck of cards or dice"],
		"specialty": ["Officer", "Scout", "Infantry", "Cavalry", "Healer", "Quatermaster", "Standard Bearer", "Support Staff"],
		"feature": [
			"Researcher": "" ],
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
