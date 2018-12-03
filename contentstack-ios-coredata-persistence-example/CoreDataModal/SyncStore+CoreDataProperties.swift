//
//  SyncStore+CoreDataProperties.swift
//  
//
//  Created by Uttam Ukkoji on 28/11/18.
//
//

import Foundation
import CoreData
import ContentstackPersistenceCoreData

extension SyncStore: SyncStoreProtocol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SyncStore> {
        return NSFetchRequest<SyncStore>(entityName: "SyncStore")
    }

    @NSManaged public var paginationToken: String?
    @NSManaged public var syncToken: String?

}
