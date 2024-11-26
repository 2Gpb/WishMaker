//
//  WishService.swift
//  HomeWork2
//
//  Created by Peter on 26.11.2024.
//
enum WishKeys: String {
    case wishList = "wishList"
}

protocol WishServiceLogic {
    func set(_ value: [String], for key: WishKeys)
    func get(for key: WishKeys) -> [String]
    func remove(for key: WishKeys)
}

class WishService: WishServiceLogic {
    private let defaults: UserDefaultsLogic
    
    init(defaults: UserDefaultsLogic = UserDefaultsService()) {
        self.defaults = defaults
    }
    
    func set(_ value: [String], for key: WishKeys) {
        defaults.set(value: value, forKey: key.rawValue)
    }
    
    func get(for key: WishKeys) -> [String] {
        defaults.get(forKey: key.rawValue, defaultValue: [])
    }
    
    func remove(for key: WishKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
