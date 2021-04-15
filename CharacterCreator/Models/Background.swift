//
//  Background.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation

///An object that holds selections made from the Background
struct Background {
    let record: BackgroundRecord
    var trait: String
    var ideal: String
    var bond: String
    var flaw: String
}

///An object representing static data for a specific background
final
class BackgroundRecord: Record {
    ///The id for the background
    private(set)
    var id: String = UUID().uuidString
    ///The name of the background
    let name: String
    ///The description of the background
    let description: String
    ///The skill proficiencices granted by this background
    let proficiencies: [String]
    ///The languages that are granted by this background
    let languages: [String]
    ///The starting items granted by this background
    let items: [String]
    ///The starting gold provided by this background
    let gold: Int
    ///A description of the relationships and features that are granted by this background
    let features: String
    ///The suggested trait options for this background
    let traits: [String]
    ///The suggested ideal options for this background
    let ideals: [String]
    ///The suggested bond options for this background
    let bonds: [String]
    ///The suggested flaw options for this background
    let flaws: [String]
}
