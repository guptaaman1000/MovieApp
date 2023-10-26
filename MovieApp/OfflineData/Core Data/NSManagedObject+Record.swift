//
//  NSManagedObject+Record.swift
//  Costco
//
//  Created by Aman Gupta on 11/17/22.
//  Copyright © 2022 Costco. All rights reserved.
//

import CoreData

extension NSManagedObject {
       
    static func all(in context: NSManagedObjectContext) async -> [NSManagedObject] {
        return await getMatchingEntities(Self.self, in: context)
    }
    
    static func all(in context: NSManagedObjectContext) -> [NSManagedObject] {
        return getMatchingEntities(Self.self, in: context)
    }
      
    static func allSorted(sortDescriptors: [NSSortDescriptor], in context: NSManagedObjectContext) async -> [NSManagedObject] {
        return await getMatchingEntities(Self.self, withSortDescriptors: sortDescriptors, in: context)
    }
    
    static func allSorted(sortDescriptors: [NSSortDescriptor], in context: NSManagedObjectContext) -> [NSManagedObject] {
        return getMatchingEntities(Self.self, withSortDescriptors: sortDescriptors, in: context)
    }
        
    static func `where`(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]? = nil, in context: NSManagedObjectContext) async -> [NSManagedObject] {
        return await getMatchingEntities(Self.self, with: predicate, withSortDescriptors: sortDescriptors, in: context)
    }

    static func `where`(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]? = nil, in context: NSManagedObjectContext) -> [NSManagedObject] {
        return getMatchingEntities(Self.self, with: predicate, withSortDescriptors: sortDescriptors, in: context)
    }
    
    func delete(in context: NSManagedObjectContext) async {
        await Self.deleteEntity(self, in: context)
    }
    
    func delete(in context: NSManagedObjectContext) {
        Self.deleteEntity(self, in: context)
    }
    
    static func deleteAll(in context: NSManagedObjectContext) async {
        await withTaskGroup(of: Void.self) {  group in
            let list = await Self.all(in: context)
            list.forEach { obj in
                group.addTask { await obj.delete(in: context) }
            }
        }
    }

    static func deleteAll(in context: NSManagedObjectContext) {
        let list = Self.all(in: context)
        list.forEach { obj in
            obj.delete(in: context)
        }
    }
    
    static func deleteAllWhere(predicate: NSPredicate, in context: NSManagedObjectContext) async {
        await withTaskGroup(of: Void.self) {  group in
            let list = await Self.where(predicate: predicate, in: context)
            list.forEach { obj in
                group.addTask { await obj.delete(in: context) }
            }
        }
    }

    static func deleteAllWhere(predicate: NSPredicate, in context: NSManagedObjectContext) {
        let list = Self.where(predicate: predicate, in: context)
        list.forEach { obj in
            obj.delete(in: context)
        }
    }   
    
    private static func getMatchingEntities<T: NSManagedObject>(
        _ entity: T.Type,
        with predicate: NSPredicate? = nil,
        withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil,
        in context: NSManagedObjectContext) async -> [T] {
        
        var fetchedArray: [T] = []
        
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

    private static func getMatchingEntities<T: NSManagedObject>(
        _ entity: T.Type,
        with predicate: NSPredicate? = nil,
        withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil,
        in context: NSManagedObjectContext) -> [T] {
        
        var fetchedArray: [T] = []
        
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
    
    private static func deleteEntity(_ entityObject: NSManagedObject, in context: NSManagedObjectContext) async {
        await context.perform {
            context.delete(entityObject)
        }
    }

    private static func deleteEntity(_ entityObject: NSManagedObject, in context: NSManagedObjectContext) {
        context.performAndWait {
            context.delete(entityObject)
        }
    }
}
