//
//  ProxyType.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

protocol ProxyType: class {
    associatedtype Defaults
    var defaults: Defaults { get set }
    var key: String { get set }
    init(_ defaults: Defaults, _ key: String)
}

extension ProxyType where Defaults: DefaultsType {
    
    // MARK: Getters
    
    var object: NSObject? {
        return defaults.objectForKey(key) as? NSObject
    }
    
    var string: String? {
        return defaults.stringForKey(key)
    }
    
    var array: NSArray? {
        return defaults.arrayForKey(key)
    }
    
    var dictionary: NSDictionary? {
        return defaults.dictionaryForKey(key)
    }
    
    var data: NSData? {
        return defaults.dataForKey(key)
    }
    
    var date: NSDate? {
        return object as? NSDate
    }
    
    var number: NSNumber? {
        return defaults.numberForKey(key)
    }
    
    var int: Int? {
        return number?.integerValue
    }
    
    var double: Double? {
        return number?.doubleValue
    }
    
    var bool: Bool? {
        return number?.boolValue
    }
    
    // MARK: Non-Optional Getters
    
    var stringValue: String {
        return string ?? ""
    }
    
    var arrayValue: NSArray {
        return array ?? []
    }
    
    var dictionaryValue: NSDictionary {
        return dictionary ?? NSDictionary()
    }
    
    var dataValue: NSData {
        return data ?? NSData()
    }
    
    var numberValue: NSNumber {
        return number ?? 0
    }
    
    var intValue: Int {
        return int ?? 0
    }
    
    var doubleValue: Double {
        return double ?? 0
    }
    
    var boolValue: Bool {
        return bool ?? false
    }
    
}