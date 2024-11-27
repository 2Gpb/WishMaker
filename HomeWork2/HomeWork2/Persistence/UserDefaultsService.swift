//
//  UserDefaultsService.swift
//  HomeWork2
//
//  Created by Peter on 26.11.2024.
//

import Foundation

protocol UserDefaultsLogic {
    func set<T>(value: T, forKey key: String)
    func get<T>(forKey key: String, defaultValue: T) -> T
    func removeObject(for key: String)
}

final class UserDefaultsService: UserDefaultsLogic {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    func set<T>(value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func get<T>(forKey key: String, defaultValue: T) -> T {
        userDefaults.object(forKey: key) as? T ?? defaultValue
    }
    
    func removeObject(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
