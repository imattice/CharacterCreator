//
//  Record.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///A type that is backed by a Static JSON file
protocol Record: Identifiable, Codable {
    var id: String { get }
    ///The name of the record
    var name: String { get }
    ///Return all records parsed from JSON
    static
    func all() -> [Self]
    ///Return a specific record that matches the input string
    static
    func record(for name: String) -> Self?
    ///Converts JSON file data to Objects
    static
    func parseFromJSON(_ dataStack: CoreDataStack) throws -> [Self]
    
}

extension Record where Self: Codable {
    ///Return all records parsed from JSON
    static
    func all() -> [Self] {
//        do {
//            return try parseAllFromJSON()
//        } catch {
//            print(error)
//            return [Self]()
//        }
        return [Self]()
    }
    
    ///Returns a specific record of the given name
    static
    func record(for name: String) -> Self? {
//        return all().filter { $0.name == name }.first
        return RuleRecord() as! Self
    }
    
    ///Converts JSON file data to an array of Records
    static
    func parseFromJSON(_ dataStack: CoreDataStack = CoreDataStack.shared) throws -> [Self] {
        //a simplistic pluralizer to transform the class record name into the json file name
        //i.e. this should return languages.json from LanguageRecord and classes.json from ClassRecord
        let filename: String = {
            let name = String(describing: Self.self).dropLast(6).lowercased()
            return name.last == "s" ? name + "es" : name + "s"
        }()

        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            //get the key that will allow the decoder to access the managed context
            guard let managedObjectContextKey = CodingUserInfoKey.managedObjectContext else { throw DecoderConfigurationError.missingCodingUserInfoKey }

            let decoder = JSONDecoder()
            //set the shared context as the decoder's context key so that the context can be used from within the init(from:Decoder) method
            decoder.userInfo[managedObjectContextKey] = dataStack.context
            return try decoder.decode([Self].self, from: data)
        }
        catch {
            print("error while parsing JSON for file \(filename).json")
            throw JSONError.parsingError
        }
    }
}
    
extension Record where Self:Codable, Self:NSManagedObject {
    static
    func save(to dataStack: CoreDataStack = CoreDataStack.shared) throws {
        //Check if there are records already stored
        guard let count = try? dataStack.context.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))).count,
              count == 0
        else { return }
        
        do {
            let records = try parseFromJSON(dataStack)
            let managedObjectContext = dataStack.context

            records.forEach { record in
                managedObjectContext.insert(record)
            }
            
            try managedObjectContext.save()
            
        } catch {
            print("error while saving to managed context")
            print(error)
            throw error
        }
    }
}



//import CoreData

///followed this blog post to conform objects to both NSManagedObject and Codable
///https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
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
