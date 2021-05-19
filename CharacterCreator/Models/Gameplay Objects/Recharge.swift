//
//  Recharge.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/19/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

///Indicates how and when an object will reset
enum Recharge: Codable, Equatable {
    ///Short and Long rest
    case shortRest,
         longRest,
         ///Indicates the minimum roll needed on 1d6 for the ability to recharge
         roll(Int)
    enum CodingKeys: CodingKey {
        case recharge
    }
    
    init(from decoder: Decoder) throws {
        do {
        let value = try decoder.singleValueContainer()
            if let string = try? value.decode(String.self) {
                switch string {
                case "longRest":
                    self = .longRest
                case "shortRest":
                    self = .shortRest
                default:
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: value.codingPath,
                            debugDescription: "Unabled to decode recharge enum."
                        )
                    )
                }
            }
            else if let int = try? value.decode(Int.self) {
                self = .roll(int)
            }
            else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Unabled to decode recharge enum."
                    )
                )
            }
        }catch{
            print(error)
            throw error
        }
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .shortRest:
            try container.encode("shortRest")
        case .longRest:
            try container.encode("longRest")
        case .roll(let minRoll):
            try container.encode(minRoll)
        }
    }
}

