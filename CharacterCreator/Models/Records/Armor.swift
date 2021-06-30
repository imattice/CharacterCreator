//
//  Armor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

/// An equippable item that can be used to increase Armor Class
struct Armor {
    
}

//MARK: - Armor Record
///An model representing static data for a specific piece of armor
@objc(ArmorRecord)
final
class ArmorRecord: ObjectRecord, Record {
    ///The base AC that is granted by the armor
    @NSManaged public var baseAC: Int
    ///The core data representation of the armorStyle property
    @NSManaged private var cdArmorStyle: String
    ///Indicates if the armor is ligh, medium, or heavy
    var armorStyle: ArmorStyle {
        get { return ArmorStyle(rawValue: cdArmorStyle)! }
        set { cdArmorStyle = newValue.rawValue }
    }
    ///Indicates if the armor imposes disadvantage on Stealth checks
    @NSManaged public var imposesStealthDisadvantage: Bool
    ///Indicates if DEX can be used when determining total AC
    @NSManaged public var addsDex: Bool
    ///The core data representation of the dexMax property
    @NSManaged private var cdDexMax: NSNumber?
    ///Indicates the maxium DEX modifier value that can be applied to the total AC when using this armor
    var dexMax: Int? {
        get {
            guard let dexMax = cdDexMax else { return nil }
            return Int(truncating: dexMax) }
        set {
            guard let dexMax = newValue else { cdDexMax = nil; return }
            cdDexMax = NSNumber(value: dexMax) }
    }
    ///The value of STR that is required in order to use this armor
    @NSManaged public var strRequired: Int

    ///Indicates if the armor is ligh, medium, or heavy
    enum ArmorStyle: String, Codable {
        case light, medium, heavy
    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.baseAC       = try container.decode(Int.self, forKey: .baseAC)
        self.armorStyle     = try container.decode(ArmorStyle.self, forKey: .armorStyle)
        self.imposesStealthDisadvantage   = try container.decodeIfPresent(Bool.self, forKey: .imposesStealthDisadvantage) ?? false
        self.addsDex   = try container.decodeIfPresent(Bool.self, forKey: .addsDex) ?? true
        self.dexMax   = try container.decodeIfPresent(Int.self, forKey: .dexMax)
        self.strRequired   = try container.decodeIfPresent(Int.self, forKey: .strRequired) ?? 0
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(baseAC, forKey: .baseAC)
        try container.encode(armorStyle, forKey: .armorStyle)
        try container.encode(imposesStealthDisadvantage, forKey: .imposesStealthDisadvantage)
        try container.encode(addsDex, forKey: .addsDex)
        try container.encode(dexMax, forKey: .dexMax)
        try container.encode(strRequired, forKey: .strRequired)
    }

    
    enum CodingKeys: CodingKey {
        case id, name, summary, details, cost, weight, baseAC, armorStyle, imposesStealthDisadvantage, addsDex, dexMax, strRequired
    }
}
