//
//  Feature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

///descrbes unique attribtue for a specific race or class
struct Feature: Codable {
    let title: String
    let detail: String
    
    static
    func decoded(from container: UnkeyedDecodingContainer) -> [Feature] {
        var mutableContainer = container
        var features = [Feature]()
        while !mutableContainer.isAtEnd {
            do {
                let feature = try mutableContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
                let title = try feature.decode(String.self, forKey: .title)
                let description = try feature.decode(String.self, forKey: .description)
                features.append(Feature(title: title, detail: description))
            } catch {
                print(error)
            }
        }
        return features
    }

    enum FeatureCodingKeys: CodingKey {
        case title, description
    }
}
