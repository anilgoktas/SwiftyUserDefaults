//
//  RawRepresentableDefaultsType.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

// MARK: - RawRepresentable

public protocol RawRepresentableDefaultsType: SubscriptableDefaultsType { }

extension RawRepresentableDefaultsType {
    
    // TODO: Ensure that T.RawValue is compatible
    public func archive<T: RawRepresentable>(key: DefaultsKey<T>, _ value: T) {
        set(key, value.rawValue)
    }
    
    public func archive<T: RawRepresentable>(key: DefaultsKey<T?>, _ value: T?) {
        if let value = value {
            set(key, value.rawValue)
        } else {
            remove(key)
        }
    }
    
    public func unarchive<T: RawRepresentable>(key: DefaultsKey<T?>) -> T? {
        return objectForKey(key._key).flatMap { T(rawValue: $0 as! T.RawValue) }
    }
    
    public func unarchive<T: RawRepresentable>(key: DefaultsKey<T>) -> T? {
        return objectForKey(key._key).flatMap { T(rawValue: $0 as! T.RawValue) }
    }
    
}