//
//  ObjectStorableDefaultsType.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

// MARK: - NSCoding

public protocol ObjectStorableDefaultsType: SubscriptableDefaultsType { }

extension ObjectStorableDefaultsType {
    
    // TODO: Can we simplify this and ensure that T is NSCoding compliant?
    
    public func archive<T>(key: DefaultsKey<T>, _ value: T) {
        if let value: AnyObject = value as? AnyObject {
            set(key, NSKeyedArchiver.archivedDataWithRootObject(value))
        } else {
            assertionFailure("Invalid value type, needs to be a NSCoding-compliant type")
        }
    }
    
    public func archive<T>(key: DefaultsKey<T?>, _ value: T?) {
        if let value: AnyObject = value as? AnyObject {
            set(key, NSKeyedArchiver.archivedDataWithRootObject(value))
        } else if value == nil {
            remove(key)
        } else {
            assertionFailure("Invalid value type, needs to be a NSCoding-compliant type")
        }
    }
    
    public func unarchive<T>(key: DefaultsKey<T?>) -> T? {
        return dataForKey(key._key).flatMap { NSKeyedUnarchiver.unarchiveObjectWithData($0) } as? T
    }
    
    public func unarchive<T>(key: DefaultsKey<T>) -> T? {
        return dataForKey(key._key).flatMap { NSKeyedUnarchiver.unarchiveObjectWithData($0) } as? T
    }
    
}