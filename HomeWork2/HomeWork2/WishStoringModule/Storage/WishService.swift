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
    func set<T>(_ value: T, for key: WishKeys)
    func get<T>(for key: WishKeys) -> T?
}

class WishService: WishServiceLogic {
    private let defaults: UserDefaultsLogic
    
    init(defaults: UserDefaultsLogic = UserDefaultsService()) {
        self.defaults = defaults
    }
    
    func set<T>(_ value: T, for key: WishKeys) {
        defaults.set(value: value, forKey: key.rawValue)
    }
    
    func get<T>(for key: WishKeys) -> T? {
        defaults.get(forKey: key.rawValue, defaultValue: nil)
    }
}
