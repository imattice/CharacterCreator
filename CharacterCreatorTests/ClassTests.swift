//
//  ClassTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 4/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest

@testable import CharacterCreator

class ClassTests: XCTestCase {
//    func testDecodingSelections() {
//        let json = """
//{
//            "equipment": [{
//        "selections": 1,
//        "options": ["a light crossbow and 20 bolts", "any simple weapon"]
//    },
//    {
//        "selections": 1,
//        "options": ["a component pouch", "an arcane focus"]
//    },
//    {
//        "selections": 1,
//        "options": ["a scholar’s pack", "a dungeoneer’s pack"]
//    },
//    {
//        "selections": 1,
//        "options": ["leather armor"]
//    },
//    {
//        "selections": 1,
//        "options": ["any simple weapon"]
//    },
//    {
//        "selections": 1,
//        "options": ["two daggers"]
//    }
//]}
//""".data(using: .utf16)
//        
//        dump(try? JSONDecoder().decode([Selection], from: json ?? <#default value#>))
//    }
    
    func testDecodingClass() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    let classJSON = """
    {
        "name": "warlock",
        "description": "",
        "hitDie": 8,
        "proficiencies": {
            "armor": ["light"],
            "weapons": ["simple"],
            "saving throws": ["wis", "cha"],
            "skills": {
                "selections": 3,
                "options": [
                    "arcana", "deception", "history", "intimidation", "investigation", "nature", "religion"
                ]
            }
        },
        "equipment": [{
                "selections": 1,
                "options": ["a light crossbow and 20 bolts", "any simple weapon"]
            },
            {
                "selections": 1,
                "options": ["a component pouch", "an arcane focus"]
            },
            {
                "selections": 1,
                "options": ["a scholar’s pack", "a dungeoneer’s pack"]
            },
            {
                "selections": 1,
                "options": ["leather armor"]
            },
            {
                "selections": 1,
                "options": ["any simple weapon"]
            },
            {
                "selections": 1,
                "options": ["two daggers"]
            }
        ],
        "features": [{
                "level": 1,
                "title": "otherworldly patron",
                "description": "At 1st level, you have struck a bargain with an otherworldly being of your choice: the Archfey, the Fiend, or the Great Old One, each of which is detailed at the end of the class description. Your choice grants you features at 1st level and again at 6th, 10th, and 14th level."
            }, {
                "level": 1,
                "title": "spellcasting",
                "description": "Your arcane research and the magic bestowed on you by your patron have given you facility with spells.\n You know two cantrips of your choice from the warlock spell list. You learn additional warlock cantrips of your choice at higher levels, as shown in the Cantrips Known column of the Warlock table.\n The Warlock table shows how many spell slots you have. The table also shows what the level of those slots is; all of your spell slots are the same level. To cast one of your warlock spells of 1st level or higher, you must expend a spell slot. You regain all expended spell slots when you finish a short or long rest.\nFor example, when you are 5th level, you have two 3rd-­‐‑level spell slots. To cast the 1st-­‐‑level spell thunderwave, you must spend one of those slots, and you cast it as a 3rd-­‐‑level spell.\nAt 1st level, you know two 1st-­‐‑level spells of your choice from the warlock spell list.\nThe Spells Known column of the Warlock table shows when you learn more warlock spells of your choice of 1st level and higher. A spell you choose must be of a level no higher than what’s shown in the table’s Slot Level column for your level. When you reach 6th level, for example, you learn a new warlock spell, which can be 1st, 2nd, or 3rd level.\nAdditionally, when you gain a level in this class, you can choose one of the warlock spells you know and replace it with another spell from the warlock spell list, which also must be of a level for which you have spell slots.\nCharisma is your spellcasting ability for your warlock spells, so you use your Charisma whenever a spell refers to your spellcasting ability. In addition, you use your Charisma modifier when setting the saving throw DC for a warlock spell you cast and when making an attack roll with one.\nSpell save DC = 8 + your proficiency bonus + your Charisma modifier\nSpell attack modifier = your proficiency bonus + your Charisma modifier\nYou can use an arcane focus as a spellcasting focus for your warlock spells."
            },
            {
                "level": 2,
                "title": "eldrich invocations",
                "description": "In your study of occult lore, you have unearthed eldritch invocations, fragments of forbidden knowledge that imbue you with an abiding magical ability.\nAt 2nd level, you gain two eldritch invocations of your choice. Your invocation options are detailed at the end of the class description. When you gain certain warlock levels, you gain additional invocations of your choice, as shown in the Invocations Known column of the Warlock table.\nAdditionally, when you gain a level in this class, you can choose one of the invocations you know and replace it with another invocation that you could learn at that level."
            },
            {
                "level": 2,
                "title": "pact boon",
                "description": "At 3rd level, your otherworldly patron bestows a gift upon you for your loyal service. You gain one of the following features of your choice.\nPact of the Chain\nYou learn the find familiar spell and can cast it as a ritual. The spell doesn’t count against your number of spells known.\nWhen you cast the spell, you can choose one of the normal forms for your familiar or one of the following special forms: imp, pseudodragon, quasit, or sprite.\nAdditionally, when you take the Attack action, you can forgo one of your own attacks to allow your familiar to make one attack of its own with its reaction.\nPact of the Blade\nYou can use your action to create a pact weapon in your empty hand. You can choose the form that this melee weapon takes each time you create it. You are proficient with it while you wield it. This weapon counts as magical for the purpose of overcoming resistance and immunity to nonmagical attacks and damage.\nYour pact weapon disappears if it is more than 5 feet away from you for 1 minute or more. It also disappears if you use this feature again, if you dismiss the weapon (no action required), or if you die.\nYou can transform one magic weapon into your pact weapon by performing a special ritual while you hold the weapon. You perform the ritual over the course of 1 hour, which can be done during a short rest. You can then dismiss the weapon, shunting it into an extradimensional space, and it appears whenever you create your pact weapon thereafter. You can’t affect an artifact or a sentient weapon in this way. The weapon ceases being your pact weapon if you die, if you perform the 1-­‐‑hour ritual on a different weapon, or if you use a 1-­‐‑hour ritual to break your bond to it. The weapon appears at your feet if it is in the extradimensional space when the bond breaks.\nPact of the Tome\nYour patron gives you a grimoire called a Book of Shadows. When you gain this feature, choose three cantrips from any class’s spell list (the three needn’t be from the same list). While the book is on your person, you can cast those cantrips at will. They don’t count against your number of cantrips known. If they don’t appear on the warlock spell list, they are nonetheless warlock spells for you.\nIf you lose your Book of Shadows, you can perform a 1-­‐‑hour ceremony to receive a replacement from your patron. This ceremony can be performed during a short or long rest, and it destroys the previous book. The book turns to ash when you die."
            },
            {
                "level": 11,
                "title": "mystic arcanum",
                "description": "At 11th level, your patron bestows upon you a magical secret called an arcanum. Choose one 6th-­‐‑ level spell from the warlock spell list as this arcanum.'nYou can cast your arcanum spell once without expending a spell slot. You must finish a long rest before you can do so again.\nAt higher levels, you gain more warlock spells of your choice that can be cast in this way: one 7th-­‐‑ level spell at 13th level, one 8th-­‐‑level spell at 15th level, and one 9th-­‐‑level spell at 17th level. You regain all uses of your Mystic Arcanum when you finish a long rest."
            },
            {
                "level": 20,
                "title": "eldrich master",
                "description": "At 20th level, you can draw on your inner reserve of mystical power while entreating your patron to regain expended spell slots. You can spend 1 minute entreating your patron for aid to regain all your expended spell slots from your Pact Magic feature. Once you regain spell slots with this feature, you must finish a long rest before you can do so again."
            }
        ],

        "subclass": [{
            "name": "the fiend",
            "description": "You have made a pact with a fiend from the lower planes of existence, a being whose aims are evil, even if you strive against those aims. Such beings desire the corruption or destruction of all things, ultimately including you. Fiends powerful enough to forge a pact include demon lords such as Demogorgon, Orcus, Fraz’Urb-­‐‑luu, and Baphomet; archdevils such as Asmodeus, Dispater, Mephistopheles, and Belial; pit fiends and balors that are especially mighty; and ultroloths and other lords of the yugoloths.",
            "features": [{
                    "level": 1,
                    "title": "expanded spell list",
                    "description": "The Fiend lets you choose from an expanded list of spells when you learn a warlock spell. The following spells are added to the warlock spell list for you.\n<INSERT TABLE HERE>"
                },
                {
                    "level": 1,
                    "title": "dark one's blessing",
                    "description": "Starting at 1st level, when you reduce a hostile creature to 0 hit points, you gain temporary hit points equal to your Charisma modifier + your warlock level (minimum of 1)."
                },
                {
                    "level": 6,
                    "title": "dark one's own luck",
                    "description": "Starting at 6th level, you can call on your patron to alter fate in your favor. When you make an ability check or a saving throw, you can use this feature to add a d10 to your roll. You can do so after seeing the initial roll but before any of the roll’s effects occur.\nOnce you use this feature, you can’t use it again until you finish a short or long rest."
                },
                {
                    "level": 14,
                    "title": "fiendish resilience",
                    "description": "Starting at 10th level, you can choose one damage type when you finish a short or long rest. You gain resistance to that damage type until you choose a different one with this feature. Damage from magical weapons or silver weapons ignores this resistance."
                },
                {
                    "level": 14,
                    "title": "hurl through hell",
                    "description": "Starting at 14th level, when you hit a creature with an attack, you can use this feature to instantly transport the target through the lower planes. The creature disappears and hurtles through a nightmare landscape.\nAt the end of your next turn, the target returns to the space it previously occupied, or the nearest unoccupied space. If the target is not a fiend, it takes 10d10 psychic damage as it reels from its horrific experience.\nOnce you use this feature, you can’t use it again until you finish a long rest."
                }
            ]
        }]
    }
    """.data(using: .utf16)
}
