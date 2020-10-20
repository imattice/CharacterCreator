//
//  CoreDataStack.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    ///The name of the core data model file that contains the entities
    private
    let modelName: String
    
    ///managed context for accessing records data
    lazy
    var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext      }()
    
    ///The reference to the data model file
    lazy private
    var model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
      return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    ///store container for records data
    lazy private
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    ///init using the default persistent container
    init(name: String) {
        self.modelName = name
    }
    
    ///specifiy a container, such as a temporary store, to initialize the data stack
    init(name: String, container: NSPersistentContainer) {
        self.modelName = name
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    ///save the records context with any changes that have been made
    func saveContext() {
        ///ensure that there were changes made
        guard managedContext.hasChanges else { print("no changes to context"); return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

class RecordDataManager: CoreDataStack {
    static
    let shared = RecordDataManager(name: "Records")
    
    static
    func loadAllRecordDataIfNeeded() {
        LanguageRecord.loadDataIfNeeded()
    }
}
