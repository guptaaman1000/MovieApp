//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Aman Gupta on 17/10/23.
//

import Foundation
import CoreData

final class CoreDataManager {

    /// Core data model name
    private let dataModelName: String
    /// Defines if data is persited in memory or hard disk
    private let isStoredInMemoryOnly: Bool

    /// The managed object context linked to the persistent store coordinator isn't associated with the main thread.
    /// Instead, it performs its work on a private queue, not on the main queue.
    /// When the private managed object context saves its changes, the write operation is performed on that private queue in the background and hence keeping the main thread free for other important tasks.
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    /// The main managed object context instance of core data stack.
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // Instead of assigning a persistent store coordinator, it acts as a child context of another private context
        // so that main thread is free for other important tasks.
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()

    /// The managed object model for the application.
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: dataModelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()

    /// A new Persistence coordinator, with a persistent store of type SQLite associated with it
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

    /// Initialize `CoreDataStack` using model name and persistent store type
    /// - Parameters:
    ///   - dataModelName: Model name
    ///   - isStoredInMemoryOnly: Persistent store type
    init(dataModelName: String, isStoredInMemoryOnly: Bool) {
        self.dataModelName = dataModelName
        self.isStoredInMemoryOnly = isStoredInMemoryOnly
    }

    /// This method saves the main context into the persistent store.
    private func saveMainContextChanges() {

        // Save main context first
        mainManagedObjectContext.perform {

            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                print("Unable to save changes of main context")
            }

            // Main context is basically a child context.
            // After saving main context, save the private context so that data is permanently persisted in the persistent store.
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

    /// Create a new managed object context instance which is a child of main managed object context.
    /// - Returns: New child managed object context
    func newChildContext() -> NSManagedObjectContext {
        let newContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        newContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        newContext.parent = self.mainManagedObjectContext
        return newContext
    }

    /// This method will save specified context into the persistent store.
    /// - Parameter context: The managed object context to be saved
    /// - Returns: TRUE if context is saved successfully otherwise FALSE
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
            // Saving of child context saves data into the parent context, which is main context in this case, instead of persistent store.
            // After saving child context, save the main context so that data is permanently persisted in the persistent store.
            saveMainContextChanges()
        }
        
        return result
    }

    /// This method will save specified context into the persistent store.
    /// - Parameter context: The managed object context to be saved
    /// - Returns: TRUE if context is saved successfully otherwise FALSE
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
            // Saving of child context saves data into the parent context, which is main context in this case, instead of persistent store.
            // After saving child context, save the main context so that data is permanently persisted in the persistent store.
            saveMainContextChanges()
        }
        
        return result
    }
    
    /// This method will save specified context into the persistent store and calls completion handler after it with save status.
    /// - Parameters:
    ///   - context: The managed object context to be saved
    ///   - completion: Completion handler called once save operation is completed
    func save(_ context: NSManagedObjectContext, completion: ((Bool) -> Void)? = nil) {
        if context != mainManagedObjectContext {
            context.perform {
                var result = true
                defer {
                    // It is not required to wait for the completion of main context saving because
                    // main context will always have all the data once the child context saving is completed.
                    DispatchQueue.main.async {
                        completion?(result)
                    }
                }
                do {
                    if context.hasChanges {
                        try context.save()
                        result = true
                        // Saving of child context saves data into the parent context, which is main context in this case, instead of persistent store.
                        // After saving child context, save the main context so that data is permanently persisted in the persistent store.
                        self.saveMainContextChanges()
                    }
                } catch {
                    print("Error while saving child context")
                    result = false
                }
            }
        } else {
            // Saving of child context saves data into the parent context, which is main context in this case, instead of persistent store.
            // After saving child context, save the main context so that data is permanently persisted in the persistent store.
            saveMainContextChanges()
            // It is not required to wait for the completion of main context saving because
            // main context will always have all the data once the child context saving is completed.
            DispatchQueue.main.async {
                completion?(true)
            }
        }
    } 
    
    /// This method will fetch the entities matching for the given predicate in sort order.
    /// - Parameters:
    ///   - entity: Type of entities to be fetched
    ///   - predicate: Predicate for filtering the data
    ///   - sortDescriptors: Condition for sorting the data
    ///   - context: Managed object context instance
    /// - Returns: An array of entities
    func getMatchingEntities<T: NSManagedObject>(
        _ entity: T.Type,
        with predicate: NSPredicate? = nil,
        withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil,
        in context: NSManagedObjectContext? = nil) async -> [T] {
            
            var fetchedArray: [T] = []
            let context = context ?? mainManagedObjectContext
            
            await context.perform {
                let fetchRequest = NSFetchRequest<T>(entityName: entity.name)
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                do {
                    fetchedArray = try context.fetch(fetchRequest)
                } catch {
                    print("Unable to fetch entity - \(entity.name) and error - \(error)")
                }
            }
            
            return fetchedArray
        }

    /// This method will fetch the entities matching for the given predicate in sort order.
    /// - Parameters:
    ///   - entity: Type of entities to be fetched
    ///   - predicate: Predicate for filtering the data
    ///   - sortDescriptors: Condition for sorting the data
    ///   - context: Managed object context instance
    /// - Returns: An array of entities
    func getMatchingEntities<T: NSManagedObject>(
        _ entity: T.Type,
        with predicate: NSPredicate? = nil,
        withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil,
        in context: NSManagedObjectContext? = nil) -> [T] {
            
            var fetchedArray: [T] = []
            let context = context ?? mainManagedObjectContext
            
            autoreleasepool {
                context.performAndWait {
                    let fetchRequest = NSFetchRequest<T>(entityName: entity.name)
                    fetchRequest.predicate = predicate
                    fetchRequest.sortDescriptors = sortDescriptors
                    do {
                        fetchedArray = try context.fetch(fetchRequest)
                    } catch {
                        print("Unable to fetch entity - \(entity.name) and error - \(error)")
                    }
                }
            }
            
            return fetchedArray
        }
    
    /// This method deletes the entities matching for the given predicate.
    /// - Parameters:
    ///   - entity: Type of entity to be deleted
    ///   - predicate: Predicate for filtering the data
    ///   - context: managed object context instance
    func deleteEntities<T: NSManagedObject>(_ entity: T.Type, with predicate: NSPredicate? = nil, in context: NSManagedObjectContext) async {
        await withTaskGroup(of: Void.self) {  group in
            let list = self.getMatchingEntities(entity, with: predicate, in: context)
            list.forEach { obj in
                group.addTask {
                    await context.perform {
                        context.delete(obj)
                    }
                }
            }
        }
    }

    /// This method deletes the entities matching for the given predicate.
    /// - Parameters:
    ///   - entity: Type of entity to be deleted
    ///   - predicate: Predicate for filtering the data
    ///   - context: managed object context instance
    func deleteEntities<T: NSManagedObject>(_ entity: T.Type, with predicate: NSPredicate? = nil, in context: NSManagedObjectContext) {
        context.performAndWait {
            let list = self.getMatchingEntities(entity, with: predicate, in: context)
            list.forEach(context.delete)
        }
    }
}
