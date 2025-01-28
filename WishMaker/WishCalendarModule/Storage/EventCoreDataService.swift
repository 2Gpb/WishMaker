//
//  EventCoreDataService.swift
//  WishMaker
//
//  Created by Peter on 27.01.2025.
//

import UIKit
import CoreData

protocol EventCoreDataServiceLogic {
    func addElement(eventModel: CalendarEventModel)
    func getElements() -> [CalendarEventModel]
    func getElement(_ id: Int) -> CalendarEventModel
    func deleteElement(id: Int)
}

final class EventCoreDataService: EventCoreDataServiceLogic {
    // MARK: - Constants
    private enum Constants {
        static let entityName: String = "Event"
        static let getElementsError: String = "Failed to get elements"
        static let getElementError: String = "Failed to get element"
        static let deleteElementError: String = "Failed to delete element"
    }
    
    // MARK: - Singleton
    static let shared: EventCoreDataServiceLogic = EventCoreDataService()
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Properties
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    // MARK: - CRUD
    func addElement(eventModel: CalendarEventModel) {
        guard let eventEntityDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: context
        ) else { return }
        let event: Event = Event(entity: eventEntityDescription, insertInto: context)
        event.title = eventModel.title
        event.note = eventModel.description
        event.startDate = eventModel.startDate
        event.endDate = eventModel.endDate
        
        appDelegate.saveContext()
    }
    
    func getElements() -> [CalendarEventModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            let events = try context.fetch(fetchRequest) as? [Event]
            var CalendarEvents: [CalendarEventModel] = []
            events?.forEach { event in
                CalendarEvents
                    .append(
                        CalendarEventModel(
                            title: event.title ?? "",
                            description: event.note ?? "",
                            startDate: event.startDate ?? Date(),
                            endDate: event.endDate ?? Date()
                        )
                    )
            }
            
            return CalendarEvents
        } catch {
            print(Constants.getElementsError + ": \(error)")
            return []
        }
    }
    
    func getElement(_ id: Int) -> CalendarEventModel {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            let events = try context.fetch(fetchRequest) as? [Event]
            return CalendarEventModel(
                title: events?[id].title ?? "",
                description: events?[id].note ?? "",
                startDate: events?[id].startDate ?? Date(),
                endDate: events?[id].endDate ?? Date()
            )
        } catch {
            print(Constants.getElementError + ": \(error)")
            return CalendarEventModel(title: "", description: "", startDate: Date(), endDate: Date())
        }
    }
    
    func deleteElement(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            guard let events = try context.fetch(fetchRequest) as? [Event],
                  events.indices.contains(id) else { return }
            context.delete(events[id])
        } catch {
            print(Constants.deleteElementError + ": \(error)")
        }
        
        appDelegate.saveContext()
    }
}
