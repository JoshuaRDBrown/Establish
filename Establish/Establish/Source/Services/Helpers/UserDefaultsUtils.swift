//
//  UserDefaultsUtils.swift
//  Establish
//
//  Created by Joshua Brown on 17/01/2022.
//

import Foundation

public class UserDefaultsUtils {
    
    public static let shared = UserDefaultsUtils()
    private let defaults = UserDefaults.standard
    
    public func isKeyAlreadySet(key: String) -> Bool {
        return defaults.string(forKey: key) != nil
    }
    
    public func getValue(for key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
    
    public func getValue(for key: String) -> String {
        return defaults.string(forKey: key) ?? ""
    }
    
    public func getValue(for key: String) -> Any? {
        return defaults.object(forKey: key)
    }
    
    public func setValue(for key: String, value: Bool) {
        defaults.set(value, forKey: key)
    }
    
    public func setValue(for key: String, value: String) {
        defaults.set(value, forKey: key)
    }
    
    public func remove(key: String) {
        defaults.removeObject(forKey: key)
    }
}
