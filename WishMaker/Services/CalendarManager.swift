//
//  CalendarService.swift
//  WishMaker
//
//  Created by Peter on 27.01.2025.
//

import Foundation
import EventKit

protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}

// MARK: - CalendarManager
final class CalendarManager: CalendarManaging {
    // MARK: - Private fields
    private let eventStore: EKEventStore = EKEventStore()
    
    // MARK: - Methods
    func create(eventModel: CalendarEventModel) -> Bool {
        var result: Bool = true
        let group = DispatchGroup()
        group.enter()
        
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        
        group.wait()
        return result
    }
    
    // MARK: - Private methods
    private func create(eventModel: CalendarEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted, error) in
            guard granted, error == nil, let self else {
                completion?(false)
                return
            }
            
            let event: EKEvent = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.notes = eventModel.description
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do {
                try self.eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
                print("failed to save event with error : \(error)")
                completion?(false)
            }
            
            completion?(true)
        }
        
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents(completion: createEvent)
        } else {
            eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}
