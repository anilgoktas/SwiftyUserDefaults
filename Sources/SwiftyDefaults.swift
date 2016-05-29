//
//  SwiftyDefaults.swift
//  SwiftyUserDefaults
//
//  Created by Anıl Göktaş on 5/29/16.
//
//

import Foundation

protocol SwiftyDefaults: RawRepresentableDefaultsType, ObjectStorableDefaultsType {
    associatedtype Proxy
}