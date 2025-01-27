//
//  Event+CoreDataProperties.swift
//  WishMaker
//
//  Created by Peter on 27.01.2025.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?

}

extension Event : Identifiable {

}
