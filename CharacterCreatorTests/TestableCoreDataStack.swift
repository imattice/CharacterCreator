//
//  TestableCoreDataStack.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData
@testable import CharacterCreator

class TestableRecordsDataStack: CoreDataStack {
    init() {
        let modelName = "Records"

        ///create a model and container to be used to initialize the data stack
        let model: NSManagedObjectModel = {
            let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
              return NSManagedObjectModel(contentsOf: modelURL)!
            }()
        let container = NSPersistentContainer(
            name: modelName,
          managedObjectModel: model)
        
        ///set the store to use the in memory storage
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }

        ///initialize
        super.init(name: modelName, container: container)
  }
}
