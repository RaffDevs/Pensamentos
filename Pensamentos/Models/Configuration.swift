//
//  Configuration.swift
//  Pensamentos
//
//  Created by Rafael Veronez Dias on 24/01/23.
//

import Foundation

enum UserDefaultKeys: String {
    case timeInterval = "timeInterval"
    case colorScheme = "colorScheme"
    case autoRefresh = "autoRefresh"
}

class Configuration {
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var timeInterval: Double {
        get {
            return defaults.double(forKey: UserDefaultKeys.timeInterval.rawValue )
        }
        set {
            defaults.setValue(newValue, forKey: UserDefaultKeys.timeInterval.rawValue)
        }
    }
    
    var colorScheme: Int {
        get {
            return defaults.integer(forKey: UserDefaultKeys.colorScheme.rawValue )
        }
        set {
            defaults.setValue(newValue, forKey: UserDefaultKeys.colorScheme.rawValue)
        }
    }
    
    var autoRefresh: Bool {
        get {
            return defaults.bool(forKey: UserDefaultKeys.autoRefresh.rawValue )
        }
        set {
            defaults.setValue(newValue, forKey: UserDefaultKeys.autoRefresh.rawValue)
        }
    }
    
    private init() {
        if (timeInterval == 0) {
            timeInterval = 8.0
        }
    }
    
    
}
