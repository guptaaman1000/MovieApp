//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Aman Gupta on 17/10/23.
//

import Foundation
import CoreData

class CoreDataManager {

    private let dataModelName: String
    private let isStoredInMemoryOnly: Bool

    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: dataModelName, withExtension: "momd") else {
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
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent("\(dataModelName).sqlite")
        
        do {
            let storeType = isStoredInMemoryOnly ? NSInMemoryStoreType : NSSQLiteStoreType
            try persistentStoreCoordinator.addPersistentStore(ofType: storeType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Add Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()

    init(dataModelName: String, isStoredInMemoryOnly: Bool) {
        self.dataModelName = dataModelName
        self.isStoredInMemoryOnly = isStoredInMemoryOnly
    }

    private func saveMainContextChanges() {

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
        let newContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        newContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        newContext.parent = self.mainManagedObjectContext
        return newContext
    }

    func saveAndWait(in context: NSManagedObjectContext) async -> Bool {
        
        var result = true
        
        if context != mainManagedObjectContext {
            await context.perform {
                do {
                    if context.hasChanges {
                        try context.save()
                        result = true
                    }
                } catch {
                    print("Error while saving child context")
                    result = false
                }
            }
        }
        
        if result {
            saveMainContextChanges()
        }
        
        return result
    }

    func saveAndWait(in context: NSManagedObjectContext) -> Bool {
        
        var result = true
        
        if context != mainManagedObjectContext {
            context.performAndWait({
                do {
                    if context.hasChanges {
                        try context.save()
                        result = true
                    }
                } catch {
                    print("Error while saving child context")
                    result = false
                }
            })
        }
        
        if result {
            saveMainContextChanges()
        }
        
        return result
    }

    func save(_ context: NSManagedObjectContext, completion: ((Bool) -> Void)? = nil) {
        if context != mainManagedObjectContext {
            context.perform {
                var result = true
                defer {
                    DispatchQueue.main.async {
                        completion?(result)
                    }
                }
                do {
                    if context.hasChanges {
                        try context.save()
                        result = true
                        self.saveMainContextChanges()
                    }
                } catch {
                    print("Error while saving child context")
                    result = false
                }
            }
        } else {
            saveMainContextChanges()
            DispatchQueue.main.async {
                completion?(true)
            }
        }
    }        
}
