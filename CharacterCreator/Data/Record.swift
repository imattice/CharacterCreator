//
//  Record.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData


///followed this blog post to conform objects to both NSManagedObject and Codable
///https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/


protocol Record {
    ///name of the record
    var name: String { get }
    
    ///return all records parsed from JSON
    static
    func all() -> [Self]
    
    ///return a specific record that matches the input string
    static
    func record(for name: String) -> Self?
    
    ///converts JSON file data to Objects
    static
    func parseAllFromJSON() throws -> [Self]
}

extension Record where Self: Codable {
    static
    func all() -> [Self] {
        do {
            return try parseAllFromJSON()
        } catch {
            print(error)
            return [Self]()
        }
    }
    
    ///fetches a specific record of the given name
    static
    func record(for name: String) -> Self? {
        return all().filter { $0.name == name }.first
    }
    
    ///decodes JSON from file
    static
    func parseAllFromJSON() throws -> [Self] {
        ///a very simplistic pluralizer to transform the class record name into the json file name
        ///i.e. this should return languages.json from LanguageRecord and classes.json from ClassRecord
        let filename: String = {
            let name = String(describing: Self.self).dropLast(6).lowercased()
            return name.last == "s" ? name + "es" : name + "s"
        }()

        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            return try JSONDecoder().decode([Self].self, from: data)
        }
        catch {
            print("error while parsing JSON for file \(filename).json")
            print(error)
            throw JSONError.parsingError
        }
    }
}




//MARK: - Core Data Implementation
//protocol Record {
//    var name: String? { set get }
//
//    static
//    func record(for name: String) -> Self?
//
//    static
//    func records(matching name: String) -> [Self]
//
//    static
//    func parseAllFromJSON() throws -> [Self]
//
//    static
//    func loadDataIfNeeded()
//}
//
//extension Record where Self: Decodable {
//    ///decodes JSON from file
//    static
//    func parseAllFromJSON() throws -> [Self] {
//        ///a very simplistic pluralizer to transform the class record name into the json file name
//        ///i.e. this should return languages.json from LanguageRecord and classes.json from ClassRecord
//        let filename: String = {
//            let name = String(describing: Self.self).dropLast(6).lowercased()
//            return name.last == "s" ? name + "es" : name + "s"
//        }()
//
//        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
//        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }
//
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
//            let decoder = JSONDecoder()
//            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = RecordDataManager.shared.managedContext
//
//            return try decoder.decode([Self].self, from: data)
//        }
//        catch {
//            print("error while parsing JSON for file \(filename).json")
//            print(error)
//            throw JSONError.parsingError
//        }
//    }
//}
//
//extension Record where Self: Decodable, Self: NSManagedObject {
////MARK: - Core Data fetch methods
//    ///fetches all records of this type from the RecordDataManager shared instance
//    static
//    func all() -> [Self] {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))
//        guard let fetch = try? RecordDataManager.shared.managedContext.fetch(request) as? [Self]
//        else {
//            print("failed to fetch all for \(String(describing: Self.self))");
//            return [Self]() }
//
//        return fetch
//    }
//
//    ///fetches a specific record of the given name
//    static
//    func record(for name: String) -> Self? {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))
//        request.predicate = NSPredicate(format: "name == %@", name)
//
//        guard let fetchedResult = try? RecordDataManager.shared.managedContext.fetch(request).first as? Self
//        else { return nil }
//
//        return fetchedResult
//    }
//
//    ///fetches all records that match a given partial name
//    static
//    func records(matching name: String) -> [Self] {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))
//        request.predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
//
//        guard let fetchedResult = try? RecordDataManager.shared.managedContext.fetch(request) as? [Self]
//        else { return [Self]() }
//
//        return fetchedResult
//    }
//
////MARK: - JSON to Core Data methods
//    ///loads data from JSON file to the Core Data Model
//    ///if the data model already contains data, do nothing
//    static
//    func loadDataIfNeeded() {
//        let context = RecordDataManager.shared.managedContext
//        let entityName = String(describing: Self.self)
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//
//        guard let count = try? context.count(for: request), count == 0
//        else { print("data for \(entityName) is present"); return }
//
//        let data: [Self]? = try? parseAllFromJSON()
//
//        guard let records = data else { return  }
//        for record in records {
//            context.insert(record)
//        }
//
//        RecordDataManager.shared.saveContext()
//    }
//
//}
//
//
