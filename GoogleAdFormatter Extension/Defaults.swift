//
//  Defaults.swift
//  GoogleAdFormatter Extension
//
//  Created by Mohssen Fathi on 1/22/20.
//  Copyright © 2020 Mohssen Fathi. All rights reserved.
//

import Foundation

struct Defaults {
    static func save<T: Codable>(_ value: T, key: String) {
        guard let data = try? encoder.encode(value) else { return }
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    static func get<T: Codable>(key: String) -> T? {
        guard let data = userDefaults.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    private static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
}
