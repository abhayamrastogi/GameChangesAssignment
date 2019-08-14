//
//  UserDefaultsUtil.swift
//  GameChangesAssignment
//
//  Created by Abhayam Rastogi on 15/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

struct UserDefaultsUtil {

    public enum ReservedKey: String {
        case date = "date"
    }
    
    public static func setDate(_ date: Date, key: ReservedKey) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: key.rawValue)
        userDefaults.synchronize()
    }
    
    public static func getDate(_ key: ReservedKey) -> Date? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: key.rawValue) as? Date
    }
}
