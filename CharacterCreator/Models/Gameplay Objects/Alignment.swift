//
//  Alignment.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/10/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

///Contains options for alignments for creatures and players
enum Alignment: String, Codable {
    case lawfulGood, neutralGood, chaoticGood, lawfulNeutral, neutral, chaoticNeutral, lawfulEvil, neutralEvil, chaoticEvil, unaligned, any
}
