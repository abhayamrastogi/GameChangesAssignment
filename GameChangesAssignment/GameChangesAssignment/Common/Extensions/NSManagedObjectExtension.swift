//
//  NSManagedExtension.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 15/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import CoreData

extension NSManagedObject {

    class var entityName: String {
        var name = NSStringFromClass(self)
        name = name.components(separatedBy: ".").last!
        let index = name.index(name.endIndex, offsetBy: -(name.count - 2))
        return String(name.suffix(from: index))
    }
    
    class func createFetchRequest<T: NSManagedObject>(predicate: NSPredicate? = nil,
                                                      sortDescriptors: [NSSortDescriptor]? = nil) -> NSFetchRequest<T> {
        
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
    
    class func all(orderedBy sortDescriptors: [NSSortDescriptor]? = nil,
                   in context: NSManagedObjectContext) -> [NSManagedObject]? {
        let request = createFetchRequest(sortDescriptors: sortDescriptors)
        var fetchedObjects = [NSManagedObject]()
        
        context.performAndWait {
            do {
                fetchedObjects = try context.fetch(request)
            } catch {
                debugPrint(error)
            }
        }
        
        return fetchedObjects.count > 0 ? fetchedObjects : nil
    }
    
    class func deleteAll(context: NSManagedObjectContext){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            debugPrint(error)
        }
    }
}
