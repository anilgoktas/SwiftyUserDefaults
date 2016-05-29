//
//  DefaultsType.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

/// NSUserDefaults & NSUbiquitousKeyValueStore shared functions

public protocol DefaultsType: class {
    func objectForKey(aKey: String) -> AnyObject?
    func removeObjectForKey(aKey: String)
    func removeAll()
    
    func hasKey(aKey: String) -> Bool
    func remove(aKey: String)
    
    func stringForKey(aKey: String) -> String?
    func arrayForKey(aKey: String) -> [AnyObject]?
    func dictionaryForKey(aKey: String) -> [String : AnyObject]?
    func dataForKey(aKey: String) -> NSData?
    func integerForKey(aKey: String) -> Int
    func doubleForKey(aKey: String) -> Double
    func boolForKey(aKey: String) -> Bool
    func URLForKey(aKey: String) -> NSURL?
    
    func setInteger(value: Int, forKey aKey: String)
    func setDouble(value: Double, forKey aKey: String)
    func setBool(value: Bool, forKey aKey: String)
    func setURL(url: NSURL?, forKey aKey: String)
}

extension DefaultsType {
    
    /// `NSNumber` representation of a user default
    
    func numberForKey(key: String) -> NSNumber? {
        return objectForKey(key) as? NSNumber
    }
    
    /// Returns `true` if `key` exists
    
    public func hasKey(key: String) -> Bool {
        return objectForKey(key) != nil
    }
    
    /// Removes value for `key`
    
    public func remove(key: String) {
        removeObjectForKey(key)
    }
    
}