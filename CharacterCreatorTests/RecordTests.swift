//
//  RecordTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 4/15/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator

class RecordTests: XCTestCase {
    func testAll() {
        let races = RaceRecord.all()
        XCTAssertEqual(races.count, 9)
        
        let classes = ClassRecord.all()
        XCTAssertEqual(classes.count, 12)
        
        let backgrounds = BackgroundRecord.all()
        XCTAssertEqual(backgrounds.count, 1)

        let items = ItemRecord.all()
        XCTAssertEqual(items.count, 100)
        let weapons = WeaponRecord.all()
        XCTAssertEqual(weapons.count, 36)
        let armor = ArmorRecord.all()
        XCTAssertEqual(armor.count, 13)
        let shields = ShieldRecord.all()
        XCTAssertEqual(shields.count, 1)
        let poisons = PoisonRecord.all()
        XCTAssertEqual(poisons.count, 14)

        
        let packs = PackRecord.all()
        XCTAssertEqual(packs.count, 7)
        
        let tools = ToolRecord.all()
        XCTAssertEqual(tools.count, 35)
        
        let spells = SpellRecord.all()
        XCTAssertEqual(spells.count, 318)
        
        let creatures = CreatureRecord.all()
        XCTAssertEqual(creatures.count, 320)
        
        let feats = FeatRecord.all()
        XCTAssertEqual(feats.count, 1)
        
        let conditions = ConditionRecord.all()
        XCTAssertEqual(conditions.count, 15)
        
        let magicItems = MagicalItemRecord.all()
        XCTAssertEqual(magicItems.count, 308)
        
        let diseases = DiseaseRecord.all()
        XCTAssertEqual(diseases.count, 3)
        
        let traps = TrapRecord.all()
        XCTAssertEqual(traps.count, 11)
        
        let rules = RuleRecord.all()
        XCTAssertEqual(rules.count, 54)
    }
    
    func testSubraceInitialization() {
        let races = RaceRecord.all()
        guard let dwarf = races.filter({ $0.name == "dwarf" }).first,
              let subrace = dwarf.subraces,
              let hillDwarf = subrace.first
        else { XCTFail(); return }
        
        XCTAssertTrue(hillDwarf.name == "hill dwarf")
    }
    
    
    //MARK: SINGULAR INSTANCE TESTS
    //MARK: RACE
    func testRaceSingularInstanceJSON() {
        let data = """
            [{
                    "name": "dwarf",
                    "description": "Stout and stubborn, a dwarf is known for their tenacity with metalwork and ores.  They can often be found in deep recesses of mountains, underground and generally keeping to themselves.",
                    "age": "Dwarves mature at the same rate as humans, but they’re considered young until they reach the age of 50. On average, they live about 350 years.",
                    "alignment": "Most dwarves are lawful, believing firmly in the benefits of a well-ordered society. They tend toward good as well, with a strong sense of fair play and a belief that everyone deserves to share in the benefits of a just order.",
                    "physique": "Dwarves stand between 4 and 5 feet tall and average about 150 pounds.",
                    "size": "medium",
                    "hasDarkvision": true,
                    "speed": 30,
                    "features": [{
                            "title": "Dwarven Resilience",
                            "description": "You have advantage on saving throws against poison, and you have resistance against poison damage."
                        },
                        {
                            "title": "Dwarven Combat Training",
                            "description": "You have proficiency with the battleaxe, handaxe, light hammer, and warhammer."
                        },
                        {
                            "title": "Tool Proficiency",
                            "description": "You gain proficiency with the artisan’s tools of your choice: smith’s tools, brewer’s supplies, or mason’s tools.",
                            "options": ["smith’s tools", "brewer’s supplies", "mason’s tools"]
                        },
                        {
                            "title": "Stonecunning",
                            "description": "Whenever you make an Intelligence (History) check related to the origin of stonework, you are considered proficient in the History skill and add double your proficiency bonus to the check, instead of your normal proficiency bonus."
                        }
                    ],
                    "abilityScoreModifiers": [{
                        "stat": "con",
                        "value": 2,
                        "origin": "race"
                    }],
                    "baseLanguages": [
                        "common",
                        "dwarvish"
                    ],
                    "subraces": [{
                        "name": "hill dwarf",
                        "description": "As a hill dwarf, you have keen senses, deep intuition, and remarkable resilience.",
                        "abilityScoreModifiers": {
                            "wis": 1
                        },
                        "features": [{
                            "title": "Dwarven Toughness",
                            "description": "Your hit point maximum increases by 1, and it increases by 1 every time you gain a level."
                        }]
                    }]
                }]
        """.data(using: .utf8)!
       
        do {
            let record = try JSONDecoder().decode([RaceRecord].self, from: data)
            dump(record)
        }
        catch {
            print(error)
            XCTFail(); return
        }
    }
    
    //MARK: - Class
    func testClassSingularInstanceJSON() {
        let data = """
        [{
        "name": "ranger",
        "description": "",
        "hitDie": 10,
        "proficiencies": {
            "armor": ["light", "medium", "shield"],
            "weapons": ["simple", "martial"],
            "savingThrows": ["str", "dex"],
            "skills": {
                "limit": 3,
                "options": [
                    "animal handling", "athletics", "insight", "investigation", "nature", "perception", "stealth", "survival"
                ]
            }
        },
        "equipmentOptions": [{
                "limit": 1,
                "options": ["scale mail", "leather armor"]
            },
            {
                "limit": 1,
                "options": ["two shortswords", "two simple melee weapons"]
            },
            {
                "limit": 1,
                "options": ["a dungeoneer’s pack", "an explorer’s pack"]
            },
            {
                "limit": 1,
                "options": ["a longbow and a quiver of 20 arrows"]
            }
        ],
        "features": [{
                "level": 1,
                "title": "favored enemy",
                "description": "Beginning at 1st level, you have significant experience studying, tracking, hunting, and even talking to a certain type of enemy.\\nChoose a type of favored enemy: aberrations, beasts, celestials, constructs, dragons, elementals, fey, fiends, giants, monstrosities, oozes, plants, or undead. Alternatively, you can select two races of humanoid (such as gnolls and orcs) as favored enemies.\\nYou have advantage on Wisdom (Survival) checks to track your favored enemies, as well as on Intelligence checks to recall information about them.\\nWhen you gain this feature, you also learn one language of your choice that is spoken by your favored enemies, if they speak one at all.\\nYou choose one additional favored enemy, as well as an associated language, at 6th and 14th level. As you gain levels, your choices should reflect the types of monsters you have encountered on your adventures."
            },
            {
                "level": 2,
                "title": "natrual explorer",
                "description": "You are particularly familiar with one type of natural environment and are adept at traveling and surviving in such regions. Choose one type of favored terrain: arctic, coast, desert, forest, grassland, mountain, or swamp. When you make an Intelligence or Wisdom check related to your favored terrain, your proficiency bonus is doubled if you are using a skill that you’re proficient in.\\nWhile traveling for an hour or more in your favored terrain, you gain the following benefits:\\n• Difficult terrain doesn’t slow your group’s travel.\\n• Your group can’t become lost except by magical means.\\n• Even when you are engaged in another activity while traveling (such as foraging, navigating, or tracking), you remain alert to danger.\\n• If you are traveling alone, you can move stealthily at a normal pace.\\n• When you forage, you find twice as much food as you normally would.\\n• While tracking other creatures, you also learn their exact number, their sizes, and how long ago they passed through the area.\\n You choose additional favored terrain types at 6th and 10th level."
            },
            {
                "level": 2,
                "title": "fighting style",
                "description": "At 2nd level, you adopt a particular style of fighting as your specialty. Choose one of the following options. You can’t take a Fighting Style option more than once, even if you later get to choose again.\\nArchery\\nYou gain a +2 bonus to attack rolls you make with ranged weapons.\\nDefense\\nWhile you are wearing armor, you gain a +1 bonus to AC.\\nDueling\\nWhen you are wielding a melee weapon in one hand and no other weapons, you gain a +2 bonus to damage rolls with that weapon.\\nTwo-Weapon Fighting\\nWhen you engage in two-­‐‑weapon fighting, you can add your ability modifier to the damage of the second attack."
            },
            {
                "level": 2,
                "title": "Spellcasting",
                "description": "By the time you reach 2nd level, you have learned to use the magical essence of nature to cast spells, much as a druid does.\\nThe Ranger table shows how many spell slots you have to cast your spells of 1st level and higher. To cast one of these spells, you must expend a slot of the spell’s level or higher. You regain all expended spell slots when you finish a long rest.\\nFor example, if you know the 1st-­‐‑level spell animal friendship and have a 1st-­‐‑level and a 2nd-­‐‑level spell slot available, you can cast animal friendship using either slot.\\nYou know two 1st-­‐‑level spells of your choice from the ranger spell list.\\nThe Spells Known column of the Ranger table shows when you learn more ranger spells of your choice. Each of these spells must be of a level for which you have spell slots. For instance, when you reach 5th level in this class, you can learn one new spell of 1st or 2nd level.\\nAdditionally, when you gain a level in this class, you can choose one of the ranger spells you know and replace it with another spell from the ranger spell list, which also must be of a level for which you have spell slots.\\nWisdom is your spellcasting ability for your ranger spells, since your magic draws on your attunement to nature. You use your Wisdom whenever a spell refers to your spellcasting ability. In addition, you use your Wisdom modifier when setting the saving throw DC for a ranger spell you cast and when making an attack roll with one.\\nSpell save DC = 8 + your proficiency bonus + your Wisdom modifier\\nSpell attack modifier = your proficiency bonus + your Wisdom modifier"
            },
            {
                "level": 3,
                "title": "ranger archetype",
                "description": "At 3rd level, you choose an archetype that you strive to emulate, such as the Hunter. Your choice grants you features at 3rd level and again at 7th, 11th, and 15th level."
            },
            {
                "level": 3,
                "title": "primeval awareness",
                "description": "Beginning at 3rd level, you can use your action and expend one ranger spell slot to focus your awareness on the region around you. For 1 minute per level of the spell slot you expend, you can sense whether the following types of creatures are present within 1 mile of you (or within up to 6 miles if you are in your favored terrain): aberrations, celestials, dragons, elementals, fey, fiends, and undead. This feature doesn’t reveal the creatures’ location or number."
            },
            {
                "level": 4,
                "title": "ability score improvement",
                "description": "When you reach 4th level, and again at 8th, 12th, 16th, and 19th level, you can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature."
            },
            {
                "level": 5,
                "title": "extra attack",
                "description": "Beginning at 5th level, you can attack twice, instead of once, whenever you take the Attack action on your turn."
            },
            {
                "level": 8,
                "title": "land's stride",
                "description": "Starting at 8th level, moving through nonmagical difficult terrain costs you no extra movement. You can also pass through nonmagical plants without being slowed by them and without taking damage from them if they have thorns, spines, or a similar hazard.\\nIn addition, you have advantage on saving throws against plants that are magically created or manipulated to impede movement, such those created by the entangle spell."
            },
            {
                "level": 10,
                "title": "hide in plain sight",
                "description": "Starting at 10th level, you can spend 1 minute creating camouflage for yourself. You must have access to fresh mud, dirt, plants, soot, and other naturally occurring materials with which to create your camouflage.\\nOnce you are camouflaged in this way, you can try to hide by pressing yourself up against a solid surface, such as a tree or wall, that is at least as tall and wide as you are. You gain a +10 bonus to Dexterity (Stealth) checks as long as you remain there without moving or taking actions. Once you move or take an action or a reaction, you must camouflage yourself again to gain this benefit."
            },
            {
                "level": 14,
                "title": "vanish",
                "description": "Starting at 14th level, you can use the Hide action as a bonus action on your turn. Also, you can’t be tracked by nonmagical means, unless you choose to leave a trail."
            },
            {
                "level": 18,
                "title": "feral senses",
                "description": "At 18th level, you gain preternatural senses that help you fight creatures you can’t see. When you attack a creature you can’t see, your inability to see it doesn’t impose disadvantage on your attack rolls against it.\\nYou are also aware of the location of any invisible creature within 30 feet of you, provided that the creature isn’t hidden from you and you aren’t blinded or deafened."
            },
            {
                "level": 20,
                "title": "foe slayer",
                "description": "At 20th level, you become an unparalleled hunter of your enemies. Once on each of your turns, you can add your Wisdom modifier to the attack roll or the damage roll of an attack you make against one of your favored enemies. You can choose to use this feature before or after the roll, but before any effects of the roll are applied."
            }
        ],

        "subclass": [{
            "name": "hunter",
            "description": "Emulating the Hunter archetype means accepting your place as a bulwark between civilization and the terrors of the wilderness. As you walk the Hunter’s path, you learn specialized techniques for fighting the threats you face, from rampaging ogres and hordes of orcs to towering giants and terrifying dragons.",
            "features": [{
                    "level": 3,
                    "title": "hunter's prey",
                    "description": "At 3rd level, you gain one of the following features of your choice.\\nColossus Slayer. Your tenacity can wear down the most potent foes. When you hit a creature with a weapon attack, the creature takes an extra 1d8 damage if it’s below its hit point maximum. You can deal this extra damage only once per turn.\\nGiant Killer. When a Large or larger creature within 5 feet of you hits or misses you with an attack, you can use your reaction to attack that creature immediately after its attack, provided that you can see the creature.\\nHorde Breaker. Once on each of your turns when you make a weapon attack, you can make another attack with the same weapon against a different creature that is within 5 feet of the original target and within range of your weapon."
                },
                {
                    "level": 7,
                    "title": "defensive tactics",
                    "description": "At 7th level, you gain one of the following features of your choice.\\nEscape the Horde. Opportunity attacks against you are made with disadvantage.\\nMultiattack Defense. When a creature hits you with an attack, you gain a +4 bonus to AC against all subsequent attacks made by that creature for the rest of the turn.\\nSteel Will. You have advantage on saving throws against being frightened."
                },
                {
                    "level": 11,
                    "title": "multiattack",
                    "description": "At 11th level, you gain one of the following features of your choice.\\nVolley. You can use your action to make a ranged attack against any number of creatures within 10 feet of a point you can see within your weapon’s range. You must have ammunition for each target, as normal, and you make a separate attack roll for each target.\\nWhirlwind Attack. You can use your action to make a melee attack against any number of creatures within 5 feet of you, with a separate attack roll for each target."
                },
                {
                    "level": 15,
                    "title": "superier hunter's defense",
                    "description": "At 15th level, you gain one of the following features of your choice.\\nEvasion. When you are subjected to an effect, such as a red dragon’s fiery breath or a lightning bolt spell, that allows you to make a Dexterity saving throw to take only half damage, you instead take no damage if you succeed on the saving throw, and only half damage if you fail.\\nStand Against the Tide. When a hostile creature misses you with a melee attack, you can use your reaction to force that creature to repeat the same attack against another creature (other than itself) of your choice.\\nUncanny Dodge. When an attacker that you can see hits you with an attack, you can use your reaction to halve the attack’s damage against you."
                }
            ]
        }]
        }]
        """.data(using: .utf8)!
        
        
            do {
                let record = try JSONDecoder().decode([ClassRecord].self, from: data)
                dump(record)
            }
            catch {
                print(error)
                XCTFail(); return
            }

    }
}
