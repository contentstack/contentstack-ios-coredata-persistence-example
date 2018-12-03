//
//  Session+CoreDataProperties.swift
//  
//
//  Created by Uttam Ukkoji on 28/11/18.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var sessionId: Int64
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String?
    @NSManaged public var uid: String?
    @NSManaged public var publishLocale: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var locale: String?
    @NSManaged public var isPopular: Bool
    @NSManaged public var startTime: NSDate?
    @NSManaged public var endTime: NSDate?

}
