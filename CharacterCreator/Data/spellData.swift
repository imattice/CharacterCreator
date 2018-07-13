//
//  spellData.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
enum SpellKey: String {
	case level, school, cast, range, damage, damageType, components, material, duration, description, requiresConcentration, atHigherLevels, shape, save, isRitual, target, actions, effect }
enum TargetKey: String {
	case number, damage, damageType, save, shape }
enum DamageKey: String {
	case value, type
}


let spellData: [String: Any ] = [
//MARK: Level 0 Spells
	//damaging cantrips increase
	"Acid Splash": [
		"level": "0",
		"school": "conjuration",
		"cast": "1 action",
		"range": "60 feet",
		"components": "v, s",
		"duration": "Instantaneous",
		"damage": [
			"value": "6",
			"type": "acid",],
		"targets": ">2",
		"save": [
			"stat": "dex",
			"effectOnSuccess": "no damage" ],
		"shape": [
			"size": "5 feet",
			"shape": "sphere"],
		"description": "Conjure an corrosive bubble of liquid that can damage ajacent targets.", ],
	"Dancing Lights": [
		"level": "0",
		"school": "evocation",
		"cast": "1 action",
		"range": "120 feet",
		"components": "v, s, m",
		"material": "a bit of phosphorus or wychwood, or a glowworm",
		"duration": "1 minute",
		"requiresConcentration": true,
		"effent": "dim light",
		"targets": ">4",
		"shape": [
			"size": "10",
			"shape": "sphere" ],
		"actions": [
			"move_light": "Move a light to a location within 20 feet of another light, and not further than 120 feet away from the caster.",
			"combine": "Merge all 4 lights to create a glowing shape of medium size."],
		"description": "Summon up to 4 floating sources of light that you can manipulate at will.", ],
	"Fire Bolt": [
		"level": 	"0",
		"school": 	"evocation",
		"cast": 	"1 action",
		"range": 	"120 feet",
		"components": "v, s",
		"duration": "Instantaneous",
		"targets": "1",
		"damage": [
			"value": "10",
			"type": "fire",],
		"effect": "ignites",
		"description": "Strike a distant target with a streak of searing flame."],
	"Guidance": [
		"level": "0",
		"school": "divination",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s",
		"duration": "1 minute",
		"requiresConcentration": true,
		"targets": "1",
		"modifier": [
			"type": "ability_check",
			"value": "4" ],
		"description": "Remove a foreseen obstacle before it occurs, granting the target a slight advantage in their next endevor." ],
	"Light": [
		"level": "0",
		"school": "evocation",
		"cast": "1 action",
		"range": "touch",
		"components": "v, m",
		"material": "a firefly or phosphorescent moss",
		"duration": "1 hour",
		"shape": [
			"size": "20",
			"shape": "sphere" ],
		"effect": "bright light",
		"save": [
			"stat": "dex",
			"success": "no_effect" ],
		"description": "Bring forth the natural light from within a small object, illuminating it and it's surrounding area.", ],
	"Mage Hand": [
		"level": "0",
		"school": "conjuration",
		"cast": "1 action",
		"range": "30 feet",
		"components": "v, s",
		"duration": "1 minute",
		"description": "Five fingers of manipulative force obey your will, increasing your reach and allowing you to carry a light object.",
		"original": "A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again. You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it. The hand can’t attack, activate magic items, or carry more than 10 pounds.", ],
	"Minor Illusion": [
		"level": "0",
		"school": "illusion",
		"cast": "1 action",
		"range": "30 feet",
		"components": "s, m",
		"material": "a bit of fleece",
		"duration": "1 minute",
		"description": "Bend light or sound ever so slightly to create an illusiory distraction",
		"original": "You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again. If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else’s voice, a lion’s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends. If you create an image of an object—such as a chair, muddy footprints, or a small chest—it must be no larger than a 5-foot cube. The image can’t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it. If a creature uses its action to examine the sound or image, the creature can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the illusion becomes faint to the creature.", ],
	"Poison Spray": [
		"level": "0",
		"school": "conjuration",
		"cast": "1 action",
		"range": "10 feet",
		"damage": "1d12",
		"damageType": "poison",
		"components": "v, s",
		"duration": "Instantaneous",
		"description": "A noxious fume bursts from your palm, causing damage",
		"original":"", ],
	"Prestidigitation": [
		"level": "0",
		"school": "transmutation",
		"cast": "1 action",
		"range": "10 feet",
		"components": "v, s",
		"duration": "1 hour",
		"description": "A performance trick that interacts with physical objects, such as creating a shower of sparks, extinquishing a small flame, or clean a tiny object",
		"original": """
			This spell is a minor magical trick that novice spellcasters use for practice. You create one of the following magical effects within range:
			• You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor.
			• You instantaneously light or snuff out a candle, a torch, or a small campfire.
			• You instantaneously clean or soil an object no larger than 1 cubic foot.
			• You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour.
			• You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour.
			• You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.
			If you cast this spell multiple times, you can have up to three of its non-instantaneous effects active at a time, and you can dismiss such an effect as an action.
			""", ],
	"Ray of Frost": [
		"level": "0",
		"school": "evocation",
		"cast": "1 action",
		"range": "60 feet",
		"components": "v, s",
		"duration": "Instantaneous",
		"damage": "1d8",
		"damageType": "cold",
		"description": "A focused beam of concentrated cold that slows and damages a target",
		"original": "A frigid beam of blue-white light streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, it takes 1d8 cold damage, and its speed is reduced by 10 feet until the start of your next turn.",],
	"Resistance": [
		"level": "0",
		"school": "abjuration",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s, m",
		"material": "a miniature cloak",
		"duration": "1 minute",
		"requiresConcentration": true,
		"description": "Ward your target from hostile magics, granting a small boost in resistance.",
		"original": "You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one saving throw of its choice. It can roll the die before or after making the saving throw. The spell then ends.", ],
	"Sacred Flame": [
		"level": "0",
		"school": "evocation",
		"cast": "1 action",
		"range": "60 feet",
		"components": "v, s",
		"duration": "Instantaneous",
		"damage": "1d8",
		"damageType": "radiant",
		"description": "Envelope a target in an omnipotent heat, causing damage and ignoring cover.",
		"original":"Flame-like radiance descends on a creature that you can see within range. The target must succeed on a Dexterity saving throw or take 1d8 radiant damage. The target gains no benefit from cover for this saving throw.",],
	"Shocking Grasp": [
		"level": "0",
		"school": "evocation",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s",
		"duration": "Instantaneous",
		"damage": "1d8",
		"damageType": "lightning",
		"description":"With electricity dancing among your hands, you touch a target, damaging it and stunning it enough to prevent any reactions.",
		"original": "Lightning springs from your hand to deliver a shock to a creature you try to touch. Make a melee spell attack against the target. You have advantage on the attack roll if the target is wearing armor made of metal. On a hit, the target takes 1d8 lightning damage, and it can’t take reactions until the start of its next turn.", ],
	"Spare the Dying": [
		"level": "0",
		"school": "necromancy",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s",
		"duration": "Instantaneous",
		"description": "Quickly reach into the land of the dead to pull a target back from the brink, stablizing its soul into its body.",
		"original": "You touch a living creature that has 0 hit points. The creature becomes stable. This spell has no effect on undead or constructs.", ],
	"Thaumaturgy": [
		"level": "0",
		"school": "transmutation",
		"cast": "1 action",
		"range": "30 feet",
		"components": "v",
		"duration": "1 minute",
		"description": "Perform an intimidating feat of godlihood, causing an effect like the earth to shake, your voice to boom, or flames to flicker",
		"original": """
			You manifest a minor wonder, a sign of supernatural power, within range. You create one of the following magical effects within range:
			• Your voice booms up to three times as loud as normal for 1 minute.
			• You cause flames to flicker, brighten, dim, or change color for 1 minute.
			• You cause harmless tremors in the ground for 1 minute.
			• You create an instantaneous sound that originates from a point of your choice within range, such as a rumble of thunder, the cry of a raven, or ominous whispers.
			• You instantaneously cause an unlocked door or window to fly open or slam shut.
			• You alter the appearance of your eyes for 1 minute.
			If you cast this spell multiple times, you can have up to three of its 1-minute effects active at a time, and you can dismiss such an effect as an action.
		""", ],

//MARK: Level 1 Spells
	"Bless": [
		"level": "1",
		"school": "enchantment",
		"cast": "1 action",
		"range": "30 feet",
		"components": "v, s, m",
		"material": "a sprinkling of holy water",
		"duration": "1 minute",
		"requiresConcentration": true,
		"description": "Invoke a higher power to provide a slight advantage to three targets that increases their accuracy or resistance.",

		"original": "You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st." ],
	"Burning Hands": [
		"level": "1",
		"school": "evocation",
		"cast": "1 action",
		"range": "self",
		"shape": "15 foot cone",
		"components": "v, s",
		"duration": "Instantaneous",
		"damage": "3d6",
		"damageType": "fire",
		"save": "dex",
		"description": "Flames erupt from your hands in an instant, spreading fire and destruction in a cone in front of you.",
		"original": "As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a Dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one. The fire ignites any flammable objects in the area that aren’t being worn or carried.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st." ],
	"Charm Person": [
		"level": "1",
		"school": "enchantment",
		"cast": "1 action",
		"range": "30 feet",
		"components": "v, s",
		"duration": "1 hour",
		"description": "Hypnotize a sentient creature into becoming a familiar aquantiance of yours.",
		"original":"You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st. The creatures must be within 30 feet of each other when you target them." ],
	"Command": [
		"level": "1",
		"school": "enchantment",
		"cast": "1 action",
		"range": "60 feet",
		"components": "v",
		"duration": "1 round",
		"description": "Bend a creatures will until it breaks, allowing you to make a single-word demand of it before it recovers.",
		"original": """
			You speak a one-word command to a creature you can see within range. The target must succeed on a Wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn’t understand your language, or if your command is directly harmful to it. Some typical commands and their effects follow. You might issue a command other than one described here. If you do so, the DM determines how the target behaves. If the target can’t follow your command, the spell ends.
			Approach. The target moves toward you by the shortest and most direct route, ending its turn if it moves within 5 feet of you.
			Drop. The target drops whatever it is holding and then ends its turn.
			Flee. The target spends its turn moving away from you by the fastest available means.
			Grovel. The target falls prone and then ends its turn.
			Halt. The target doesn’t move and takes no actions. A flying creature stays aloft, provided that it is able to do so. If it must move to stay aloft, it flies the minimum distance needed to remain in the air.
			""",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, you can affect one additional creature for each slot level above 1st. The creatures must be within 30 feet of each other when you target them." ],
	"Comprehend Languages": [
		"level": "1",
		"school": "divination",
		"isRitual": true,
		"cast": "1 action",
		"range": "self",
		"components": "v, s, m",
		"material": "a pinch of soot and salt",
		"duration": "1 hour",
		"description": "Translate at an unnatural rate, giving you the ability to understand spoken language and written words while accurately interpreting their meaning.",
		"original": "For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text. This spell doesn’t decode secret messages in a text or a glyph, such as an arcane sigil, that isn’t part of a written language." ],
	"Cure Wounds": [
		"level": "1",
		"school": "evocation",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s",
		"duration": "instant",
		"description": "Accelerate the body's natural regenration, knitting lesions and mending bones in mere seconds.",
		"original":"A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d8 for each slot level above 1st."],
	"Detect Magic": [
		"level": "1",
		"school": "divination",
		"isRitual": true,
		"cast": "1 action",
		"range": "self",
		"components": "v, s",
		"duration": "1 minute",
		"requiresConcentration": true,
		"description": "Attune yourself to the presense of magic, granting you the ability to know where and what kind of magic may be present.",
		"original": "For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any. The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt." ],
	"Disguise Self": [
		"level": "1",
		"school": "illusion",
		"cast": "1 action",
		"range": "self",
		"components": "v, s",
		"duration": "1 hour",
		"requiresConcentration": true,
		"description": "Wrap yourself in an illusion, slightly altering the appearance of your clothes, face, and height.",
		"original": "You make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can’t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you. The changes wrought by this spell fail to hold up to physical inspection. For example, if you use this spell to add a hat to your outfit, objects pass through the hat, and anyone who touches it would feel nothing or would feel your head and hair. If you use this spell to appear thinner than you are, the hand of someone who reaches out to touch you would bump into you while it was seemingly still in midair. To discern that you are disguised, a creature can use its action to inspect your appearance and must succeed on an Intelligence (Investigation) check against your spell save DC." ],
	"Guiding Bolt": [
		"level": "1",
		"school": "evocation",
		"cast": "1 action",
		"range": "120 feet",
		"components": "v, s",
		"duration": "1 round",
		"damage": "4d6",
		"damageType": "radiant",
		"description": "A streak of light shoots toward a creature, exploding on hit and covering it in a dim glittering glow.",
		"original": "A flash of light streaks toward a creature of your choice within range. Make a ranged spell attack against the target. On a hit, the target takes 4d6 radiant damage, and the next attack roll made against this target before the end of your next turn has advantage, thanks to the mystical dim light glittering on the target until then.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st."],
	"Healing Word": [
		"level": "1",
		"school": "evocation",
		"cast": "1 bonus action",
		"range": "60 feet",
		"components": "v",
		"duration": "instant",
		"description": "Speak the word of healing, as a band of runes circle a creature's wound to provide a soothing mending effect.",
		"original": "A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d4 for each slot level above 1st."],
	"Identify": [
		"level": "1",
		"school": "divination",
		"isRitual": true,
		"cast": "1 minute",
		"range": "touch",
		"components": "v, s, m",
		"material":"a pearl worth at least 100 gp and an owl feather",
		"duration": "Instant",
		"description": "Amplify your arcane knowledge and attune yourself to the energy surrounding a magical object to learn about its properties.",
		"original": "You choose one object that you must touch throughout the casting of the spell. If it is a magic item or some other magic-imbued object, you learn its properties and how to use them, whether it requires attunement to use, and how many charges it has, if any. You learn whether any spells are affecting the item and what they are. If the item was created by a spell, you learn which spell created it. If you instead touch a creature throughout the casting, you learn what spells, if any, are currently affecting it." ],
	"Inflict Wounds": [
		"level": "1",
		"school": "necromancy",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s",
		"duration": "Instant",
		"damage": "3d10",
		"damageType": "necrotic",
		"description": "Cleave skin.  Rupture blood vessels. Break bones. Cause damage.",
		"original": "Make a melee spell attack against a creature you can reach. On a hit, the target takes 3d10 necrotic damage.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d10 for each slot level above 1st." ],
	"Mage Armor": [
		"level": "1",
		"school": "abjuration",
		"cast": "1 action",
		"range": "touch",
		"components": "v, s, m",
		"material":"a piece of cured leather",
		"duration": "8 hours",
		"description": "Encase a target with a shimmering ward that grants resistance to physical attacks.",
		"original": "You touch a willing creature who isn’t wearing armor, and a protective magical force surrounds it until the spell ends. The target’s base AC becomes 13 + its Dexterity modifier. The spell ends if the target dons armor or if you dismiss the spell as an action." ],
	"Magic Missile": [
		"level": "1",
		"school": "evocation",
		"cast": "1 action",
		"range": "120 feet",
		"components": "v, s",
		"duration": "Instant",
		"damage": "1d4 + 1",
		"damageType": "force",
		"description": "Three bolts arc toward a target with unshakable accuracy.",
		"original": "You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the spell creates one more dart for each slot level above 1st."],
	"Sanctuary": [
		"level": "1",
		"school": "abjuration",
		"cast": "1 bonus action",
		"range": "30 feet",
		"components": "v, s, m",
		"material":"a small silver mirror",
		"duration": "1 minute",
		"description": "Shroud a target in a veil of protection, forcing any enemy willing to attack your ward to overcome your protective might.",
		"original": "You ward a creature within range against attack. Until the spell ends, any creature who targets the warded creature with an attack or a harmful spell must first make a Wisdom saving throw. On a failed save, the creature must choose a new target or lose the attack or spell. This spell doesn’t protect the warded creature from area effects, such as the explosion of a fireball. If the warded creature makes an attack or casts a spell that affects an enemy creature, this spell ends." ],
	"Shield": [
		"level": "1",
		"school": "abjuration",
		"cast": "1 reaction",
		"range": "self",
		"components": "v, s",
		"duration": "1 round",
		"description": "Branish a barrier of magical force to temporarily increase your protection from physical and magical attacks.",
		"original": "An invisible barrier of magical force appears and protects you. Until the start of your next turn, you have a +5 bonus to AC, including against the triggering attack, and you take no damage from magic missile." ],
	"Shield of Faith": [
		"level": "1",
		"school": "abjuration",
		"cast": "1 bonus action",
		"range": "60 feet",
		"components": "v, s, m",
		"material": "a small parchment with a bit of holy text written on it",
		"duration": "10 minutes",
		"requiresConcentration": true,
		"description": "Help to repel attacks that are aimed towards your target by granting a sacred shell of protection.",
		"original": "A shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to AC for the duration." ],
	"Silent Image": [
		"level": "1",
		"school": "illusion",
		"cast": "1 action",
		"range": "60 feet",
		"components": "v, s, m",
		"material": "a bit of fleece",
		"duration": "10 minutes",
		"requiresConcentration": true,
		"description": "Weave an illusiory image of a medium-sized object or creature.",
		"original": "You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn’t accompanied by sound, smell, or other sensory effects. You can use your action to cause the image to move to any spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. For example, if you create an image of a creature and move it, you can alter the image so that it appears to be walking. Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image." ],
	"Sleep": [
		"level": "1",
		"school": "enchantment",
		"cast": "1 action",
		"range": "90 feet",
		"components": "v, s, m",
		"material": "a pinch of fine sand, rose petals, or a cricket)",
		"duration": "1 minute",
		"description": "The call to rest becomes too overwhelming to resist as you whisper the words that send your targets into a deep slumber",
		"original": "This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points (ignoring unconscious creatures). Starting with the creature that has the lowest current hit points, each creature affected by this spell falls unconscious until the spell ends, the sleeper takes damage, or someone uses an action to shake or slap the sleeper awake. Subtract each creature’s hit points from the total before moving on to the creature with the next lowest hit points. A creature’s hit points must be equal to or less than the remaining total for that creature to be affected. Undead and creatures immune to being charmed aren’t affected by this spell.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, roll an additional 2d8 for each slot level above 1st."],
	"Thunderwave": [
		"level": "1",
		"school": "evocation",
		"cast": "1 action",
		"range": "self",
		"shape": "15-foot cube",
		"components": "v, s",
		"duration": "Instant",
		"damage": "2d8",
		"damageType": "thunder",
		"description": "An electromagnetic pulse emits from your body, pushing others away and causing damage.",
		"original":"A wave of thunderous force sweeps out from you. Each creature in a 15-foot cube originating from you must make a Constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn’t pushed. In addition, unsecured objects that are completely within the area of effect are automatically pushed 10 feet away from you by the spell’s effect, and the spell emits a thunderous boom audible out to 300 feet.",
		"atHigherLevels": "When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d8 for each slot level above 1st."],
	//MARK: Level 2 Spells
	//MARK: Level 3 Spells
	//MARK: Level 4 Spells
	//MARK: Level 5 Spells
	//MARK: Level 6 Spells
	//MARK: Level 7 Spells
	//MARK: Level 8 Spells
	//MARK: Level 9 Spells

]
