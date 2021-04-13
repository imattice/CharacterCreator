//
//  Feature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

//MARK: - Feature
///descrbes unique feature that will affect gameplay
class Feature: Encodable, Identifiable {
    ///the id of the feature
    var id: String = UUID().uuidString
    ///the title of the feature
    let title: String
    ///a paragraph describing the feature's effects
    let description: String
    ///the source of the feature
    let origin: Origin
    
    init(title: String, description: String, origin: Origin) {
        self.title          = title
        self.description    = description
        self.origin         = origin
    }
    
    ///decodes an Unkeyed JSON decoding container into an array of Features and SelectableFeatures
    static
    func decoded(from container: UnkeyedDecodingContainer, source: Origin) -> [Feature] {
        var mutableContainer = container
        var features = [Feature]()
        while !mutableContainer.isAtEnd {
            do {
                let feature = try mutableContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
                
                let title = try feature.decode(String.self, forKey: .title)
                let description = try feature.decode(String.self, forKey: .description)
                
                //determine if there are options that are a custom array of strings
                if let options = try? feature.decodeIfPresent([String].self, forKey: .options) {
                    features.append(SelectableFeature(title: title, description: description, origin: source, options: options.map({ SelectionOption($0)})))    }
                
                //if there are no options, just create and add a basic feature
                else {
                    features.append(Feature(title: title, description: description, origin: source))    }
                
            } catch {
                print(error)
            }
        }
        return features
    }

    enum FeatureCodingKeys: CodingKey {
        case title, description, options
    }
}

//MARK: - SelectableFeature
class SelectableFeature: Feature, Selectable, ObservableObject {
    ///holds all potential options for this feature
    @Published
    var options: [SelectionOption]
    ///the maximum number of selections that are allowed to be made
    let selectionLimit: Int

    init(title: String, description: String, origin: Origin, options: [SelectionOption], limit: Int = 1) {
        self.options = options
        self.selectionLimit = limit

        super.init(title: title, description: description, origin: origin)
    }
}

//MARK: - Spellcasting Feature
class SpellcastingFeature: Feature {
    ///The stat used to cast spells
    let stat: Stat
    ///The number of slots per class level, where the index of the parent array is the class level and the index of the contained array is the slot level
    ///The first index of the contained array represents the number of cantrips that are known at that level
    let slots: [[Int]]
    ///The maxium number of spells available for the character at a particular level
    let spellCount: Int
    ///The list of spells that are either known or prepared by the class
    let knownSpells: [String]
    ///The selection of spells available to this class
    let spellList: [String]
    ///Indicates if the character can cast rituals
    let canCastRitual: Bool = false
    ///Indicates if the class prepares or knows the spells
    let memoryType: MemoryType
    
    ///Indicates if the class prepares or knows the spells
    enum MemoryType {
        case known, prepared
    }
}



//MARK: - Protocol Conformance
extension Feature: Equatable, Hashable {
    static func == (lhs: Feature, rhs: Feature) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.origin == rhs.origin
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
