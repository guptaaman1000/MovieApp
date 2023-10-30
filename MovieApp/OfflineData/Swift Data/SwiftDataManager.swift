//
//  SwiftDataManager.swift
//  MovieApp
//
//  Created by Aman Gupta on 24/10/23.
//

import Foundation
import SwiftData

final class SwiftDataManager {
    
    /// Collection of supported entities
    private let supportedEntities: [any PersistentModel.Type]
    /// Defines if data is persited in memory or hard disk
    private let isStoredInMemoryOnly: Bool
    
    private lazy var modelContainer: ModelContainer = {
        let schema = Schema(supportedEntities)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    /// The main  context associated with the model container.
    @MainActor var mainContext: ModelContext {
        modelContainer.mainContext
    }
    
    init(supportedEntities: [any PersistentModel.Type], isStoredInMemoryOnly: Bool) {
        self.supportedEntities = supportedEntities
        self.isStoredInMemoryOnly = isStoredInMemoryOnly
    }
    
    /// Creates a new custom context.
    /// - Returns: New custom context
    func newContext() -> ModelContext {
        ModelContext(modelContainer)
    }
    
    /// This method will save specified context into the persistent store and calls completion handler after it with save status.
    /// - Parameters:
    ///   - context: The model context to be saved
    ///   - completion: Completion handler called once save operation is completed
    func save(_ context: ModelContext, completion: ((Bool) -> Void)? = nil) {
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
            }
        } catch {
            print("Error while saving child context")
            result = false
        }
    }

    /// This method will fetch the entities matching for the given predicate in sort order.
    /// - Parameters:
    ///   - entity: Type of entities to be fetched
    ///   - predicate: Predicate for filtering the data
    ///   - sortDescriptors: Condition for sorting the data
    ///   - context: Model context instance
    /// - Returns: An array of entities
    @MainActor func getMatchingEntities<T: PersistentModel>(
        _ entity: T.Type,
        with predicate: Predicate<T>? = nil,
        withSortDescriptors sortDescriptors: [SortDescriptor<T>] = [],
        in context: ModelContext? = nil) -> [T] {
            
            var fetchedArray: [T] = []
            let context = context ?? mainContext
            var descriptor = FetchDescriptor<T>(predicate: predicate)
            descriptor.sortBy = sortDescriptors
            
            do {
                fetchedArray = try context.fetch(descriptor)
            } catch {
                print("Unable to fetch entity - \(entity) and error - \(error)")
            }
            
            return fetchedArray
        }
    
    /// This method deletes the entities matching for the given predicate.
    /// - Parameters:
    ///   - entity: Type of entity to be deleted
    ///   - predicate: Predicate for filtering the data
    ///   - context: Model context instance
    func deleteEntities<T: PersistentModel>(_ entity: T.Type, with predicate: Predicate<T>? = nil, in context: ModelContext) {
        do {
            try context.delete(model: entity, where: predicate)
        } catch {
            print("Unable to delete entity - \(entity) and error - \(error)")
        }
    }
}
