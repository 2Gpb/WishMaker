//
//  Wish+CoreDataProperties.swift
//  HomeWork2
//
//  Created by Peter on 29.11.2024.
//
//

import Foundation
import CoreData


extension Wish {
    @NSManaged public var id: Int16
    @NSManaged public var text: String?
}

extension Wish : Identifiable {}
