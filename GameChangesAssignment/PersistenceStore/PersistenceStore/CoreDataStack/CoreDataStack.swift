//
//  CoreDataStack.swift
//  PersistenceStore
//
//  Created by Abhayam Rastogi on 14/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack {

// MARK: Static/Class Methods
    public class func getSharedMOC() -> NSManagedObjectContext {
        return CoreDataStack.sharedInstance.managedObjectContext
    }
    
    public class func newChildOfSharedMOC() -> NSManagedObjectContext {
        return CoreDataStack.sharedInstance.newChildManagedObjectContext(ofContext: CoreDataStack.sharedInstance.managedObjectContext)
    }
    
    public class func saveSyncMOC(_ context: NSManagedObjectContext, cascadeSave: Bool) {
        if context.hasChanges == true {
            do {
                try context.save()
                
                if cascadeSave == true && context.parent != nil {
                    CoreDataStack.saveSyncMOC(context.parent!, cascadeSave: cascadeSave)
                }
            } catch {
                print(error)
            }
        }
    }
    
    public class func saveAsyncMOC(_ context: NSManagedObjectContext, cascadeSave: Bool) {
        context.perform {
            if context.hasChanges == true {
                do {
                    try context.save()
                    
                    if cascadeSave == true && context.parent != nil {
                        CoreDataStack.saveAsyncMOC(context.parent!, cascadeSave: cascadeSave)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    public class func clearAll() {
        let sc = CoreDataStack.sharedInstance.persistanceStoreCoordinator
        let ps = sc?.persistentStores.last
        let URL = ps?.url
        
        do {
            try sc?.destroyPersistentStore(at: URL!, ofType: NSSQLiteStoreType, options: nil)
            try sc?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: URL, options: nil)
            
            CoreDataStack.sharedInstance.managedObjectContext.reset()
            CoreDataStack.sharedInstance.privateWriterManagedObjectContext.reset()
            CoreDataStack.saveSyncMOC(CoreDataStack.getSharedMOC(), cascadeSave: true)
        } catch {
            print(error)
        }
    }
    
    // MARK: Properties
    
    public var managedObjectContext: NSManagedObjectContext!
    
    private var privateWriterManagedObjectContext: NSManagedObjectContext!
    private var managedObjectModel: NSManagedObjectModel!
    private var persistanceStoreCoordinator: NSPersistentStoreCoordinator!
    
    // MARK: Constants
    
    public static let sharedInstance = CoreDataStack()
    
    // MARK: Lifecycle Methods
    
    private init() {
        
        // So that we don't initialize the damn thing.
        
        managedObjectModel = getManagedObjectModel()
        persistanceStoreCoordinator = getStoreCoordinator(managedObjectModel: managedObjectModel)
        privateWriterManagedObjectContext = getPrivateWriterManagedObjectContext(coordinator: persistanceStoreCoordinator)
        managedObjectContext = getManagedObjectContext()
    }
    
    // MARK: Public Methods
    
    public func newChildManagedObjectContext(ofContext context: NSManagedObjectContext) -> NSManagedObjectContext {
        let childMOC = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        childMOC.parent = context
        
        return childMOC
    }
    
    // MARK: Open Access Methods
    
    // MARK: Private Methods
    
    public func getDocumentDirectoryURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }
    
    private func getManagedObjectModel() -> NSManagedObjectModel {
        guard managedObjectModel == nil else {
            return managedObjectModel
        }
        
        // Find this bundle
        var thisBundle: Bundle!
        let bundles: [Bundle] =  Bundle.allFrameworks
        for bundle in bundles {
            if bundle.bundleIdentifier == "change.game.PersistenceStore" {
                thisBundle = bundle
                
                break
            }
        }
        
        return NSManagedObjectModel.mergedModel(from: [thisBundle])!
    }
    
    private func getStoreCoordinator(managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
        guard persistanceStoreCoordinator == nil else {
            return persistanceStoreCoordinator
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = getDocumentDirectoryURL().appendingPathComponent("CoreData.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch let error as Error {
            print("Ops there was an error \(error.localizedDescription)")
            abort()
        }
        return coordinator
    }
    
    private func getPrivateWriterManagedObjectContext(coordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext? {
        guard privateWriterManagedObjectContext == nil else {
            return privateWriterManagedObjectContext
        }
        
        if persistanceStoreCoordinator != nil {
            let context = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            
            return context
        }
        
        return nil
    }
    
    private func getManagedObjectContext() -> NSManagedObjectContext? {
        guard managedObjectContext == nil else {
            return managedObjectContext
        }
        
        if privateWriterManagedObjectContext != nil {
            let context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
            context.parent = privateWriterManagedObjectContext
            
            return context
        }
        
        return nil
    }
}
