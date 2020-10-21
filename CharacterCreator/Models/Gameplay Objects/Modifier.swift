//
//  Modifier.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

//defines a method that changes a value or calculation for any object, such as stats, damage, or AC
//class Modifier: Codable {
//	let type: ModifierType
//	let attribute: String
//	let value: Int
//	let origin: ModifierOrigin
//
//    enum ModifierOrigin: String, Codable {
//        case race,
//             subrace,
//             `class`
//    }
//    enum ModifierType: String, Codable	{
//		case onAdvantage,
//		grantAdvantage,
//		onDisadvantage,
//		imposeDisadvantage,
//		increaseStat,
//		decreaseStat,
//		increaseHP,
//		decreaseHP
//	}
//}

class Modifier {
    let origin: Origin
    
    enum Origin: String, Codable {
        case race,
             subrace,
             `class`
    }
    
    init(origin: Origin) {
        self.origin = origin
    }
}


class AbilityScoreModifier: Modifier {
    let abilityScore: AbilityScore.Name
    let value: Int
    let adjustment: Adjustment
    let isTemporary: Bool
    
    enum Adjustment {
        case increase, decrease }
    
    init(name: AbilityScore.Name, value: Int, adjustment: Adjustment = .increase, isTemp: Bool = true, origin: Origin) {
        self.abilityScore    = name
        self.value           = value
        self.adjustment      = adjustment
        self.isTemporary     = isTemp
    
        super.init(origin: origin)
    }
}

class HPModifier: Modifier {
    let value: Int
    let isTemporary: Bool
    
    init(value: Int, isTemp: Bool, origin: Origin) {
        self.value          = value
        self.isTemporary    = isTemp
        
        super.init(origin: origin)
    }
}
