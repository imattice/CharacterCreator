//
//  PersistenceController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    /// A singleton instance for use throught the app
    static let shared = CoreDataStack()
    
    private let container: NSPersistentContainer
    ///Access to the container's context
    public lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()


    ///An initializer to load Core Data, optionally able to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Main")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    ///Save the context if changes are present
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }

}
