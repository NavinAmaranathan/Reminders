//
//  ReminderDataRepository.swift
//  Reminder
//
//  Created by Navi on 12/07/22.
//

import Foundation
import CoreData

protocol ReminderRepository {
    func getAll() -> [Reminder]?
    func create(reminder: Reminder)
    func get(byID: UUID) -> Reminder?
    func update(reminder: Reminder) -> Bool
    func delete(reminder: Reminder) -> Bool
}

struct ReminderDataRepository: ReminderRepository {
    
    /// Fetches a collection of data
    /// - Returns: Collection of Reminders
    func getAll() -> [Reminder]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: ReminderEntity.self)
        
        var reminders = [Reminder]()
        result?.forEach({ entity in
            reminders.append(entity.convertToReminder())
        })
        
        return reminders
        
    }
    
    /// Create and save a new record
    /// - Parameter reminder: Record to save
    func create(reminder: Reminder) {
        let reminderEntity = ReminderEntity(context: PersistentStorage.shared.context)
        reminderEntity.id = reminder.id
        reminderEntity.title = reminder.title
        reminderEntity.body = reminder.subtitle
        reminderEntity.date = reminder.date
        
        PersistentStorage.shared.saveContext()
    }
    
    /// Fetch a specific item
    /// - Parameter byID: Unique id mapped to entity
    /// - Returns: Actual entity
    func get(byID: UUID) -> Reminder? {
        let result = getReminderEntity(byId: byID)
        guard result != nil else {
            return nil
        }
        return result?.convertToReminder()
    }
    
    /// Updates the existing entity
    /// - Parameter reminder: Item to update
    /// - Returns: Bool on execution
    func update(reminder: Reminder) -> Bool {
        let reminderEntity = getReminderEntity(byId: reminder.id)
        guard reminderEntity != nil else { return false }
        
        reminderEntity?.title = reminder.title
        reminderEntity?.body = reminder.subtitle
        reminderEntity?.date = reminder.date
        
        PersistentStorage.shared.saveContext()
        return true
        
    }
    
    /// Delete the entry from DB
    /// - Parameter reminder: Item to delete
    /// - Returns: Bool value on execution
    func delete(reminder: Reminder) -> Bool {
        guard let reminderEntity = getReminderEntity(byId: reminder.id) else {
            return false
        }
        
        PersistentStorage.shared.context.delete(reminderEntity)
        return true
    }
    
    /// Fetches the entity based on specific id
    /// - Parameter byId: Unique id for the entry
    /// - Returns: Actual entity object
    private func getReminderEntity(byId: UUID) -> ReminderEntity? {
        let request = NSFetchRequest<ReminderEntity>(entityName: "ReminderEntity")
        let predicate = NSPredicate(format: "id==%@", byId as CVarArg)
        request.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(request).first
            guard result != nil else {
                return nil
            }
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
