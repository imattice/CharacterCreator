//
//  TestableCoreDataStack.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 10/19/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import XCTest
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

class TestableDataStackTest: XCTestCase {
    var dataStack: TestableRecordsDataStack!

    override func setUpWithError() throws {
        super.setUp()
        dataStack = TestableRecordsDataStack()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        dataStack = nil
    }
    
    func testInMemoryDataStore() {
        print(dataStack.modelName)

        let record = LanguageRecord(context: dataStack.managedContext)
        record.name = "english"
        
        let request = NSFetchRequest<LanguageRecord>(entityName: "LanguageRecord")
        dataStack.saveContext()
        
        let fetchedResults = try? dataStack.managedContext.fetch(request)
        
        XCTAssertNotNil(fetchedResults)
        XCTAssertNotNil(fetchedResults?.first)
        XCTAssertTrue(fetchedResults!.first!.name == "english")
    }
}
