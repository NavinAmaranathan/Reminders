//
//  ReminderEntity+CoreDataProperties.swift
//  Reminder
//
//  Created by Navi on 12/07/22.
//
//

import Foundation
import CoreData


extension ReminderEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderEntity> {
        return NSFetchRequest<ReminderEntity>(entityName: "ReminderEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

    func convertToReminder() -> Reminder {
        return Reminder(id: self.id!,
                        title: self.title!,
                        subtitle: self.body!,
                        date: self.date!)
    }
}

extension ReminderEntity : Identifiable {

}
