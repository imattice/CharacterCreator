//
//  Modifier.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 3/13/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

///A struct that holds an effect as well as its source
struct Modifier: Codable {
    let effect: Effect
    let source: Source

    enum Source: String, Codable {
        case race, subrace
    }

    init(_ effect: Effect, from source: Source) {
        self.source = source
        self.effect = effect
    }
}

extension Modifier: Equatable {
    static func == (lhs: Modifier, rhs: Modifier) -> Bool {
        return lhs.effect == rhs.effect && lhs.source == rhs.source
    }
}


//class StatModifier: Modifier {
//    let effect: Effect
//    let stat: Stat
//    let value: Int
//
//
//    init(effect: Effect, stat: Stat, value: Int, source: Modifier.Source) {
//        self.effect = effect
//        self.stat = stat
//        self.value = value
//
//        super.init(source)
//    }
//
//
//    required convenience init(from decoder: Decoder) throws {
//        do {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            let effect = try container.decode(Effect.self, forKey: .effect)
//            let stat = try container.decode(Stat.self, forKey: .stat)
//            let value = try container.decode(Int.self, forKey: .value)
//            let source = try container.decode(Source.self, forKey: .source)
//
//            self.init(effect: effect, stat: stat, value: value, source: source)
//        } catch {
//            print(error)
//            throw error
//        }
//    }
//
//    enum Effect: String, Codable {
//        case increase
//    }
//    enum Stat: String, Codable {
//        case str, con, dex, cha, wis, int
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case effect, value, stat, source
//    }
//}

//defines a method that changes a value or calculation for any object, such as stats, damage, or AC
//struct Modifier {
//    let type: ModifierType
//    let attribute: String
//    let value: Int
//    let origin: ModifierOrigin
//
//    enum ModifierOrigin { case race, subrace, `class` }
//    enum ModifierType    {
//        case onAdvantage,
//        grantAdvantage,
//        onDisadvantage,
//        imposeDisadvantage,
//        increaseStat,
//        decreaseStat,
//        increaseHP,
//        decreaseHP
//    }
//}
