//
//  DefaultsKeys.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

// MARK: - Static keys

/// Extend this class and add your user defaults keys as static constants
/// so you can use the shortcut dot notation (e.g. `Defaults[.yourKey]`)

public class DefaultsKeys {
    private init() {}
}

/// Base class for static user defaults keys. Specialize with value type
/// and pass key name to the initializer to create a key.

public class DefaultsKey<ValueType>: DefaultsKeys {
    // TODO: Can we use protocols to ensure ValueType is a compatible type?
    public let _key: String
    
    public init(_ key: String) {
        self._key = key
    }
}