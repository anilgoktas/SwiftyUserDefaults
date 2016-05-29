//
// SwiftyUserDefaults
//
// Copyright (c) 2015-2016 Radosław Pietruszewski
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

public extension NSUbiquitousKeyValueStore {
    class Proxy: ProxyType {
        var defaults: NSUbiquitousKeyValueStore
        var key: String
        
        required public init(_ defaults: NSUbiquitousKeyValueStore, _ key: String) {
            self.defaults = defaults
            self.key = key
        }
        
    }
}

// MARK: - DefaultsType

extension NSUbiquitousKeyValueStore: DefaultsType {
    
    /// Removes all keys and values from user defaults
    /// Use with caution!
    /// - Note: This method only removes keys on the receiver `NSUbiquitousKeyValueStore` object.
    ///         System-defined keys will still be present afterwards.
    
    public func removeAll() {
        for (key, _) in dictionaryRepresentation {
            removeObjectForKey(key)
        }
    }
    
    public func setInteger(value: Int, forKey aKey: String) {
        setObject(value, forKey: aKey)
    }
    
    public func integerForKey(aKey: String) -> Int {
        return objectForKey(aKey) as? Int ?? 0
    }
    
    public func setURL(url: NSURL?, forKey aKey: String) {
        setObject(url, forKey: aKey)
    }

    public func URLForKey(aKey: String) -> NSURL? {
        return objectForKey(aKey) as? NSURL
    }

}

/// Global shortcut for `NSUbiquitousKeyValueStore.defaultStore()`

public let iCloudDefaults = NSUbiquitousKeyValueStore.defaultStore()

// MARK: - SwiftyDefaults

extension NSUbiquitousKeyValueStore: SwiftyDefaults {
    
    /// Returns getter proxy for `key`
    
    public subscript(key: String) -> Proxy {
        return Proxy(self, key)
    }
    
    /// Sets value for `key`
    
    public subscript(key: String) -> Any? {
        get {
            // return untyped Proxy
            // (make sure we don't fall into infinite loop)
            let proxy: Proxy = self[key]
            return proxy
        }
        set {
            switch newValue {
            case let v as Int: setInteger(v, forKey: key)
            case let v as Double: setDouble(v, forKey: key)
            case let v as Bool: setBool(v, forKey: key)
            case let v as NSURL: setURL(v, forKey: key)
            case let v as NSObject: setObject(v, forKey: key)
            case nil: removeObjectForKey(key)
            default: assertionFailure("Invalid value type")
            }
        }
    }
    
}

// MARK: - Deprecations

infix operator ?= {
associativity right
precedence 90
}

/// If key doesn't exist, sets its value to `expr`
/// Note: This isn't the same as `Defaults.registerDefaults`. This method saves the new value to disk, whereas `registerDefaults` only modifies the defaults in memory.
/// Note: If key already exists, the expression after ?= isn't evaluated

@available(*, deprecated=1, message="Please migrate to static keys and use this gist: https://gist.github.com/radex/68de9340b0da61d43e60")
public func ?= (proxy: NSUbiquitousKeyValueStore.Proxy, @autoclosure expr: () -> Any) {
    if !proxy.defaults.hasKey(proxy.key) {
        proxy.defaults[proxy.key] = expr()
    }
}

/// Adds `b` to the key (and saves it as an integer)
/// If key doesn't exist or isn't a number, sets value to `b`

@available(*, deprecated=1, message="Please migrate to static keys to use this.")
public func += (proxy: NSUbiquitousKeyValueStore.Proxy, b: Int) {
    let a = proxy.defaults[proxy.key].intValue
    proxy.defaults[proxy.key] = a + b
}

@available(*, deprecated=1, message="Please migrate to static keys to use this.")
public func += (proxy: NSUbiquitousKeyValueStore.Proxy, b: Double) {
    let a = proxy.defaults[proxy.key].doubleValue
    proxy.defaults[proxy.key] = a + b
}

/// Icrements key by one (and saves it as an integer)
/// If key doesn't exist or isn't a number, sets value to 1

@available(*, deprecated=1, message="Please migrate to static keys to use this.")
public postfix func ++ (proxy: NSUbiquitousKeyValueStore.Proxy) {
    proxy += 1
}