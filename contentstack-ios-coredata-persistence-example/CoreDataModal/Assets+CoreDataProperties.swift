//
//  Assets+CoreDataProperties.swift
//  
//
//  Created by Uttam Ukkoji on 28/11/18.
//
//

import Foundation
import CoreData
import ContentstackPersistenceCoreData

extension Assets: AssetProtocol  {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assets> {
        return NSFetchRequest<Assets>(entityName: "Assets")
    }

    @NSManaged public var publishLocale: String?
    @NSManaged public var title: String?
    @NSManaged public var uid: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var fileName: String?
    @NSManaged public var url: String?

}
