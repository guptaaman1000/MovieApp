//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Aman Gupta on 28/07/21.
//  Copyright © 2021 Aman Gupta. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "Movie", withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent("\("Movie").sqlite")

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Add Persistent Store")
        }

        return persistentStoreCoordinator
    }()

    private init() { }

    private func saveChanges() {

        mainManagedObjectContext.perform {

            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                print("Unable to save changes of main context")
            }

            self.privateManagedObjectContext.perform {
                do {
                    if self.privateManagedObjectContext.hasChanges {
                        try self.privateManagedObjectContext.save()
                    }
                } catch {
                    print("Unable to save changes of private context")
                }
            }
        }
    }

    func newChildContext() -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.mainManagedObjectContext
        return managedObjectContext
    }

    func save(context: NSManagedObjectContext) {
        context.perform {
            do {
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                print("Unable to save changes of context - \(context)")
            }
            self.saveChanges()
        }
    }
}
