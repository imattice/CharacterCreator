//
//  Background.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/27/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///An object that holds selections made from the Background
struct Background {
    let record: BackgroundRecord
    var trait: String
    var ideal: String
    var bond: String
    var flaw: String
}

///An object representing static data for a specific background
@objc(BackgroundRecord)
final
class BackgroundRecord: NSManagedObject, Record, Codable {
    ///The id for the background
    @NSManaged public var id: String
    ///The name of the background
    @NSManaged public var name: String
    ///The description of the background
    @NSManaged public var summary: String
    ///The core data representation of the proficiencies property
    @NSManaged private var cdProficiencies: String
    ///The skill proficiencices granted by this background
    var proficiencies: [String] {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdProficiencies.utf8))) ?? [String]() }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdProficiencies = String(data: json, encoding:.utf8)!
           } catch { cdProficiencies = "" }
        }
    }
    @NSManaged private var cdLanguages: String
    ///The languages that are granted by this background
    var languages: [String] {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdLanguages.utf8))) ?? [String]() }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdLanguages = String(data: json, encoding:.utf8)!
           } catch { cdLanguages = "" }
        }

    }
    @NSManaged private var cdItems: String
    ///The starting items granted by this background
    var items: [Item] {
        get { return (try? JSONDecoder().decode([Item].self, from: Data(cdItems.utf8))) ?? [Item]() }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdItems = String(data: json, encoding:.utf8)!
           } catch { cdItems = "" }
        }
    }
    ///The starting gold provided by this background
    @NSManaged public var gold: Int
    @NSManaged private var cdFeature: String
    ///A description of the relationships and features that are granted by this background
    var feature: Feature {
        get { return (try? JSONDecoder().decode(Feature.self, from: Data(cdFeature.utf8)))!  }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdFeature = String(data: json, encoding:.utf8)!
           } catch { cdFeature = "" }
        }
    }
    @NSManaged private var cdTraits: String
    ///The suggested trait options for this background
    var traits: [String] {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdTraits.utf8)))!  }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdTraits = String(data: json, encoding:.utf8)!
           } catch { cdTraits = "" }
        }
    }
    @NSManaged private var cdIdeals: String
    ///The suggested ideal options for this background
    var ideals: [String] {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdIdeals.utf8)))!  }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdIdeals = String(data: json, encoding:.utf8)!
           } catch { cdIdeals = "" }
        }
    }
    @NSManaged private var cdBonds: String
    ///The suggested bond options for this background
    var bonds: [String] {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdBonds.utf8)))!  }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdBonds = String(data: json, encoding:.utf8)!
           } catch { cdBonds = "" }
        }
    }
    @NSManaged private var cdFlaws: String
    ///The suggested flaw options for this background
    var flaws: [String] {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdFlaws.utf8)))!  }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdFlaws = String(data: json, encoding:.utf8)!
           } catch { cdFlaws = "" }
        }
    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id             = UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary        = try container.decode(String.self, forKey: .summary)
        self.proficiencies  = try container.decode([String].self, forKey: .proficiencies)
        self.languages      = try container.decode([String].self, forKey: .languages)
        self.items          = try container.decode([Item].self, forKey: .items)
        self.gold           = try container.decode(Int.self, forKey: .gold)
        self.feature        = try container.decode(Feature.self, forKey: .feature)
        self.traits         = try container.decode([String].self, forKey: .traits)
        self.ideals         = try container.decode([String].self, forKey: .ideals)
        self.bonds          = try container.decode([String].self, forKey: .bonds)
        self.flaws          = try container.decode([String].self, forKey: .flaws)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(proficiencies, forKey: .proficiencies)
        try container.encode(languages, forKey: .languages)
        try container.encode(items, forKey: .items)
        try container.encode(gold, forKey: .gold)
        try container.encode(feature, forKey: .feature)
        try container.encode(traits, forKey: .traits)
        try container.encode(ideals, forKey: .ideals)
        try container.encode(bonds, forKey: .bonds)
        try container.encode(flaws, forKey: .flaws)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, proficiencies, languages, items, gold, feature, traits, ideals, bonds, flaws
    }
}
