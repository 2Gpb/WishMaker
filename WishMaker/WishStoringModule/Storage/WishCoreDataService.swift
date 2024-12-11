//
//  CoreDataService.swift
//  HomeWork2
//
//  Created by Peter on 29.11.2024.
//
import UIKit
import CoreData

// MARK: - WishCoreDataServiceLogic
protocol WishCoreDataServiceLogic {
    func logCoreDataDBPath()
    func addElement(_ id: Int16, text: String)
    func getElements() -> [String]
    func editElement(_ id: Int16, newValue: String)
    func deleteElement(_ id: Int16)
}

final class WishCoreDataService: WishCoreDataServiceLogic {
    // MARK: - Singleton
    static let shared: WishCoreDataServiceLogic = WishCoreDataService()
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Properties
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: Methods
    func logCoreDataDBPath() {
        if let url = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print("DB url - \(url)")
        }
    }
    
    // MARK: - CRUD
    func addElement(_ id: Int16, text: String) {
        guard let wishEntityDescription = NSEntityDescription.entity(
            forEntityName: "Wish",
            in: context
        ) else { return }
        let wish = Wish(entity: wishEntityDescription, insertInto: context)
        wish.id = id
        wish.text = text
        
        appDelegate.saveContext()
    }
    
    func getElements() -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        do {
            let wishes = try? context.fetch(fetchRequest) as? [Wish]
            var textWishes: [String] = []
            wishes?.forEach({ wish in
                textWishes.append(wish.text ?? "")
            })
            return textWishes
        }
    }
    
    func editElement(_ id: Int16, newValue: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first else { return }
            wish.text = newValue
        }
        appDelegate.saveContext()
    }
    
    func deleteElement(_ id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first else { return }
            context.delete(wish)
        }
        appDelegate.saveContext()
    }
}
