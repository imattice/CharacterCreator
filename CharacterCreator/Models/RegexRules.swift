//
//  RegexRules.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/25/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

enum RegexRules: String, CaseIterable {
    case die = #"\d+d\d+"#
    case damage = #"(acid|fire|cold|thunder|lightning|poison|necrotic|radient|force|bludgeoning|piercing|slashing) damage"#
    case savingThrow = #"([Ss]trength|[Cc]onstitution|[Dd]exterity|[Cc]harisma|[Ww]isdom|[Ii]ntelligence) saving throw"#
    case paragraphTitle = #"^(\d+\. )?[\w ]{1,12}\."#
    case dataTable = #"TABLE:\w+"#
    
    ///Return all rules connected as a single pattern string
    static
    func all() -> String {
        return RegexRules.allCases.map { $0.rawValue }.joined(separator: "|")
    }
    
    ///Returns the first regex rule that matches the given string
    static
    func match(_ text:String) -> RegexRules? {
       for rule in RegexRules.allCases {
            if text.matches(rule.rawValue) { return rule }
        }
        return nil
    }
}
