//
//  SubscriptableDefaultsType.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

public protocol SubscriptableDefaultsType: DefaultsType {
    subscript(key: String) -> Any? { get set }
}

extension SubscriptableDefaultsType {
    
    /// This function allows you to create your own custom Defaults subscript. Example: [Int: String]
    public func set<T>(key: DefaultsKey<T>, _ value: Any?) {
        self[key._key] = value
    }
    
    /// Returns `true` if `key` exists
    public func hasKey<T>(key: DefaultsKey<T>) -> Bool {
        return objectForKey(key._key) != nil
    }
    
    /// Removes value for `key`
    public func remove<T>(key: DefaultsKey<T>) {
        removeObjectForKey(key._key)
    }
    
}

// MARK: Subscripts for specific standard types

// TODO: Use generic subscripts when they become available

extension SubscriptableDefaultsType {
    public subscript(key: DefaultsKey<String?>) -> String? {
        get { return stringForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<String>) -> String {
        get { return stringForKey(key._key) ?? "" }
        set { set(key, newValue) }
    }
    public subscript(key: DefaultsKey<NSString?>) -> NSString? {
        get { return stringForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSString>) -> NSString {
        get { return stringForKey(key._key) ?? "" }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Int?>) -> Int? {
        get { return numberForKey(key._key)?.integerValue }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Int>) -> Int {
        get { return numberForKey(key._key)?.integerValue ?? 0 }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Double?>) -> Double? {
        get { return numberForKey(key._key)?.doubleValue }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Double>) -> Double {
        get { return numberForKey(key._key)?.doubleValue ?? 0.0 }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Bool?>) -> Bool? {
        get { return numberForKey(key._key)?.boolValue }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Bool>) -> Bool {
        get { return numberForKey(key._key)?.boolValue ?? false }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<AnyObject?>) -> AnyObject? {
        get { return objectForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSObject?>) -> NSObject? {
        get { return objectForKey(key._key) as? NSObject }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSData?>) -> NSData? {
        get { return dataForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSData>) -> NSData {
        get { return dataForKey(key._key) ?? NSData() }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSDate?>) -> NSDate? {
        get { return objectForKey(key._key) as? NSDate }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSURL?>) -> NSURL? {
        get { return URLForKey(key._key) }
        set { set(key, newValue) }
    }
    
    // TODO: It would probably make sense to have support for statically typed dictionaries (e.g. [String: String])
    
    public subscript(key: DefaultsKey<[String: AnyObject]?>) -> [String: AnyObject]? {
        get { return dictionaryForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[String: AnyObject]>) -> [String: AnyObject] {
        get { return dictionaryForKey(key._key) ?? [:] }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSDictionary?>) -> NSDictionary? {
        get { return dictionaryForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSDictionary>) -> NSDictionary {
        get { return dictionaryForKey(key._key) ?? [:] }
        set { set(key, newValue) }
    }
}

// MARK: Static subscripts for array types

extension SubscriptableDefaultsType {
    public subscript(key: DefaultsKey<NSArray?>) -> NSArray? {
        get { return arrayForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<NSArray>) -> NSArray {
        get { return arrayForKey(key._key) ?? [] }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[AnyObject]?>) -> [AnyObject]? {
        get { return arrayForKey(key._key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[AnyObject]>) -> [AnyObject] {
        get { return arrayForKey(key._key) ?? [] }
        set { set(key, newValue) }
    }
}

// We need the <T: AnyObject> and <T: _ObjectiveCBridgeable> variants to
// suppress compiler warnings about NSArray not being convertible to [T]
// AnyObject is for NSData and NSDate, _ObjectiveCBridgeable is for value
// types bridge-able to Foundation types (String, Int, ...)

extension SubscriptableDefaultsType {
    public func getArray<T: _ObjectiveCBridgeable>(key: DefaultsKey<[T]>) -> [T] {
        return arrayForKey(key._key) as NSArray? as? [T] ?? []
    }
    
    public func getArray<T: _ObjectiveCBridgeable>(key: DefaultsKey<[T]?>) -> [T]? {
        return arrayForKey(key._key) as NSArray? as? [T]
    }
    
    public func getArray<T: AnyObject>(key: DefaultsKey<[T]>) -> [T] {
        return arrayForKey(key._key) as NSArray? as? [T] ?? []
    }
    
    public func getArray<T: AnyObject>(key: DefaultsKey<[T]?>) -> [T]? {
        return arrayForKey(key._key) as NSArray? as? [T]
    }
}

extension SubscriptableDefaultsType {
    public subscript(key: DefaultsKey<[String]?>) -> [String]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[String]>) -> [String] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Int]?>) -> [Int]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Int]>) -> [Int] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Double]?>) -> [Double]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Double]>) -> [Double] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Bool]?>) -> [Bool]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Bool]>) -> [Bool] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[NSData]?>) -> [NSData]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[NSData]>) -> [NSData] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[NSDate]?>) -> [NSDate]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[NSDate]>) -> [NSDate] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
}