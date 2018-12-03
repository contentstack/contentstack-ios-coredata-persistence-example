//
//  Session+CoreDataProperties.swift
//  
//
//  Created by Uttam Ukkoji on 28/11/18.
//
//

import Foundation
import CoreData
import ContentstackPersistenceCoreData

extension Session: EntryProtocol {

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
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var locale: String?
    @NSManaged public var isPopular: Bool
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?

    public static func contentTypeid() -> String! {
        return "session"
    }
    
    public static func fieldMapping() -> [AnyHashable : Any]! {
        return ["sessionId":"session_id",
                "desc": "description",
                "type":"type",
                "isPopular":"is_popular",
                "startTime":"start_time",
                "endTime":"end_time"]
    }
    
    func sessionTime() -> String {
        var sessionTime = ""
        if let stime = self.startTime {
            sessionTime = self.sessionTimeFormatter().string(from: stime)
            if let eTime = self.endTime {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                sessionTime = "\(sessionTime) - \(dateFormatter.string(from: eTime))"
            }
        }
        return sessionTime
    }
    
    private func sessionTimeFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d, h:mm a"
        return dateFormatter
    }
}
