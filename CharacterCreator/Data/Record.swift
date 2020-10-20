//
//  Record.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

protocol Record {
    //associatedtype RecordType: Codable, NSManagedObject
    ///returns an array of RaceRecord if successfuly decoded from JSON or an empty array if failed
    ///Implementing a generic all() function here causes issues with not recognizing type
    ///this will likely be replaced by a core data fetch request in the future
    ///for now, implement this method in the subclasses individually
//    static
//    func all<T: Codable>() -> [T] {
//        let result: [T]? = try? parseAllFromJSON()
//        return result ?? [T]()
//    }
    
    static
    func parseAllFromJSON<T: Codable>() throws -> [T]
    
    @discardableResult static
    func loadDataIfNeeded<T: Codable>() -> [T]
}

extension Record where Self: Codable {
  ///decodes JSON from file
    static
    func parseAllFromJSON<T: Codable>() throws -> [T] {
        ///a very simplistic pluralizer to transform the class record name into the json file name
        ///i.e. this should return languages.json from LanguageRecord and classes.json from ClassRecord
        let filename: String = {
            let name = String(describing: T.self).dropLast(6).lowercased()
            return name.last == "s" ? name + "es" : name + "s"
        }()

        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = RecordDataManager.shared.managedContext

            return try decoder.decode([T].self, from: data)
        }
        catch {
            print("error while parsing JSON for file \(filename).json")
            print(error)
            throw JSONError.parsingError
        }
    }
    
    ///determines if there is data in the Records store
    ///if not, load the data from the JSON file
    @discardableResult static
    func loadDataIfNeeded<T: Codable>() -> [T] {
        let context = RecordDataManager.shared.managedContext
        let entityName = String(describing: T.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        guard let count = try? context.count(for: request), count == 0
        else { print("data for \(entityName) is present"); return [T]() }

        let data: [T]? = try? parseAllFromJSON()

        guard let records = data else { return [T]() }
        
        for record in records {
            context.insert(record as! NSManagedObject)
        }
        
        RecordDataManager.shared.saveContext()
        return records
    }
    
    static
    func loadDataIfNeeded() {
        let context = RecordDataManager.shared.managedContext
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        guard let count = try? context.count(for: request), count == 0
        else { print("data for \(entityName) is present"); return }

        let data: [Self]? = try? parseAllFromJSON()

        guard let records = data else { return  }
        for record in records {
            context.insert(record as! NSManagedObject)
        }

        RecordDataManager.shared.saveContext()
    }

}


