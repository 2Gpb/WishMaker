//
//  WishService.swift
//  HomeWork2
//
//  Created by Peter on 26.11.2024.
//
// MARK: - WishKeys
enum WishKeys: String {
    case wishList = "wishList"
}

// MARK: - WishServiceLogic
protocol WishServiceLogic {
    func getElements(for key: WishKeys) -> [String]
    func addElement(for key: WishKeys, newValue: String) -> [String]
    func editElement(for key: WishKeys, index: Int, newValue: String) -> [String]
    func deleteElement(for key: WishKeys, index: Int) -> [String]
}

final class WishDefaultsService: WishServiceLogic {
    // MARK: - Private fields
    private let defaults: UserDefaultsLogic
    
    // MARK: - Lifecycle
    init(defaults: UserDefaultsLogic = UserDefaultsService()) {
        self.defaults = defaults
    }
    
    // MARK: - CRUD
    func getElements(for key: WishKeys) -> [String] {
        defaults.get(forKey: key.rawValue, defaultValue: [])
    }
    
    func addElement(for key: WishKeys, newValue: String) -> [String] {
        var savedArray: [String] = defaults.get(forKey: key.rawValue, defaultValue: [])
        savedArray.append(newValue)
        defaults.set(value: savedArray, forKey: key.rawValue)
        return savedArray
    }
    
    func editElement(for key: WishKeys, index: Int, newValue: String) -> [String] {
        var savedArray: [String] = defaults.get(forKey: key.rawValue, defaultValue: [])
        savedArray[index] = newValue
        defaults.set(value: savedArray, forKey: key.rawValue)
        return savedArray
    }
    
    func deleteElement(for key: WishKeys, index: Int) -> [String] {
        var savedArray: [String] = defaults.get(forKey: key.rawValue, defaultValue: [])
        savedArray.remove(at: index)
        defaults.set(value: savedArray, forKey: key.rawValue)
        return savedArray
    }
}
