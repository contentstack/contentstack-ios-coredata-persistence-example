//
//  NSManageObject+Additions.swift
//  contentstack-ios-coredata-persistence-example
//
//  Created by Uttam Ukkoji on 28/11/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import CoreData
extension NSManagedObjectContext {
    func findAll<T:NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortBy: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortBy
        
        let fetchedResult = try! self.fetch(fetchRequest)
        return fetchedResult
    }
    
    func findOrCreate<T:NSManagedObject>(_entity: T.Type, predicate: NSPredicate? = nil) -> T {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        
        if let fetchedResult = try? self.fetch(fetchRequest), let objectModal = fetchedResult.first {
            return objectModal
        }
        let entity = NSEntityDescription.entity(forEntityName: T.entity().name!, in: self)
        let objectModal = NSManagedObject(entity: entity!, insertInto: self)

        return objectModal as! T
    }
}
