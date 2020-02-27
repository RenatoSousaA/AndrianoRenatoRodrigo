//
//  Configuration.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 26/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import Foundation

enum userDefaultsKeys: String {
    case dolar = "dolar"
    case iof = "iof"
}

class Configuration {
    
    let defauts = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    var dolar: Double {
        get {
            return defauts.double(forKey: userDefaultsKeys.dolar.rawValue)
        }
        set {
            defauts.set(newValue, forKey: userDefaultsKeys.dolar.rawValue)
        }
    }
    
    var iof: Double {
        get {
            return defauts.double(forKey: userDefaultsKeys.iof.rawValue)
        }
        set {
            defauts.set(newValue, forKey: userDefaultsKeys.iof.rawValue)
        }
    }
    
    private init() {
        if defauts.double(forKey: userDefaultsKeys.dolar.rawValue) == 0 {
            defauts.set(3.2, forKey: userDefaultsKeys.dolar.rawValue)
        }
        
        if defauts.double(forKey: userDefaultsKeys.iof.rawValue) == 0 {
            defauts.set(6.38, forKey: userDefaultsKeys.iof.rawValue)
        }
    }
    
}
