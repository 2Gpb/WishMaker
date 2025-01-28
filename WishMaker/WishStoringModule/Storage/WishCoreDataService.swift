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
    func addElement(text: String)
    func getElements() -> [String]
    func getElement(_ id: Int) -> String
    func editElement(_ id: Int, newValue: String)
    func deleteElement(_ id: Int)
}

final class WishCoreDataService: WishCoreDataServiceLogic {
    // MARK: - Constants
    private enum Constants {
        static let entityName: String = "Wish"
        static let getElementsError: String = "Failed to get elements"
        static let getElementError: String = "Failed to get element"
        static let editElementError: String = "Failed to edit element"
        static let deleteElementsError: String = "Failed to delete element"
    }
    
    // MARK: - Singleton
    static let shared: WishCoreDataServiceLogic = WishCoreDataService()
    
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
    func addElement(text: String) {
        guard let wishEntityDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: context
        ) else { return }
        let wish = Wish(entity: wishEntityDescription, insertInto: context)
        wish.text = text
        
        appDelegate.saveContext()
    }
    
    func getElements() -> [String] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            let wishes = try context.fetch(fetchRequest) as? [Wish]
            var textWishes: [String] = []
            wishes?.forEach({ wish in
                textWishes.append(wish.text ?? "")
            })
            
            return textWishes
        } catch {
            print(Constants.getElementsError + ": \(error)")
            return []
        }
    }
    
    func getElement(_ id: Int) -> String {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            let wishes = try context.fetch(fetchRequest) as? [Wish]
            return wishes?[id].text ?? ""
        } catch {
            print(Constants.getElementError + ": \(error)")
            return ""
        }
    }
    
    func editElement(_ id: Int, newValue: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            guard let wishes = try context.fetch(fetchRequest) as? [Wish],
                  wishes.indices.contains(id) else { return }
            let wishToEdit = wishes[id]
            wishToEdit.text = newValue
        } catch {
            print(Constants.editElementError + ": \(error)")
        }
        
        appDelegate.saveContext()
    }

    func deleteElement(_ id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        do {
            guard let wishes = try context.fetch(fetchRequest) as? [Wish],
                  wishes.indices.contains(id) else { return }
            context.delete(wishes[id])
        } catch {
            print(Constants.deleteElementsError + ": \(error)")
        }
        
        appDelegate.saveContext()
    }
}
