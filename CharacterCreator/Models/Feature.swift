//
//  Feature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

///descrbes unique feature that will affect gameplay
struct Feature: Codable {
    ///the title of the feature
    let title: String
    ///a paragraph describing the feature's effects
    let description: String
    ///the source of the feature
    let origin: Origin
    
    ///decodes an Unkeyed JSON decoding container into an array of Features
    static
    func decoded(from container: UnkeyedDecodingContainer, source: Origin) -> [Feature] {
        var mutableContainer = container
        var features = [Feature]()
        while !mutableContainer.isAtEnd {
            do {
                let feature = try mutableContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
                let title = try feature.decode(String.self, forKey: .title)
                let description = try feature.decode(String.self, forKey: .description)
                features.append(Feature(title: title, description: description, origin: source))
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
