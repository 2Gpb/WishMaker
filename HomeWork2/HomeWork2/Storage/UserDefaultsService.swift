//
//  UserDefaultsService.swift
//  HomeWork2
//
//  Created by Peter on 26.11.2024.
//

import Foundation

protocol UserDefaultsLogic {
    func set(value: [String], forKey key: String)
    func get(forKey key: String, defaultValue: [String]) -> [String]
    func removeObject(forKey key: String)
}

final class UserDefaultsService: UserDefaultsLogic {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    func set(value: [String], forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func get(forKey key: String, defaultValue: [String]) -> [String] {
        if let data = userDefaults.object(forKey: key) as? [String] {
            return data
        }
        return defaultValue
    }
    
    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
