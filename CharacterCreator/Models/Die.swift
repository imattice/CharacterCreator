//
//  Die.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/10/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

struct Die: Codable {
    let count: Int
    let value: Int
    
    var display: String { return "\(count)d\(value)" }
    
    init?(from string: String) {
        guard string.matches("^[0-9]+d[0-9]+$"),
              let multiplierString     = string.components(separatedBy: "d").first,
              let valueString            = string.components(separatedBy: "d").last,
              let count            = Int(multiplierString),
              let value                = Int(valueString)
        else { print("invalid string format: \(string)"); return nil }
        
        self.count = count
        self.value = value
    }
}
