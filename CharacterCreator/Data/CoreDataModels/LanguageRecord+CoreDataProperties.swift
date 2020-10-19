//
//  LanguageRecord+CoreDataProperties.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//
//

import Foundation
import CoreData


extension LanguageRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanguageRecord> {
        return NSFetchRequest<LanguageRecord>(entityName: "LanguageRecord")
    }

    @NSManaged public var id: String?
    ///who commonly speaks this language
    @NSManaged public var spokenBy: String?
    ///which script the writing of this language is based off of
    @NSManaged public var script: String?
    ///if the language is rare
    @NSManaged public var isExotic: Bool
    ///the name of the language
    @NSManaged public var name: String?
    ///if the language is secret
    @NSManaged public var isSecret: Bool

}

extension LanguageRecord : Identifiable {

}
