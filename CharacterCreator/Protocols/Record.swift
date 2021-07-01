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
protocol Record: NSManagedObject, Identifiable, Codable {
    var id: String { get }
    ///The name of the record
    var name: String { get }
    ///Return all records parsed from JSON
    static
    func all(in context: NSManagedObjectContext) -> [Self]
    ///Return a specific record that matches the input string
    static
    func record(for name: String, in context: NSManagedObjectContext) -> Self?
    ///Converts JSON file data to an array of Records
    static
    func parseFromJSON(_ dataStack: CoreDataStack) throws -> [Self]
}

extension Record {
    ///Return all records parsed from JSON
    static
    func all(in context: NSManagedObjectContext = CoreDataStack.shared.context) -> [Self] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))
        guard let results = try? context.fetch(request) as? [Self]
        else {
            print("failed to fetch all for \(String(describing: Self.self))");
            return [Self]() }

        return results
    }
    ///Returns a specific record of the given name
    static
    func record(for name: String, in context: NSManagedObjectContext = CoreDataStack.shared.context) -> Self? {
        let request = NSFetchRequest<Self>(entityName: String(describing: Self.self))
        request.predicate = NSPredicate(format: "name == %@", name)

        guard let fetchedResult = try? context.fetch(request).first
        else { return nil }

        return fetchedResult

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
    
extension Record {
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
