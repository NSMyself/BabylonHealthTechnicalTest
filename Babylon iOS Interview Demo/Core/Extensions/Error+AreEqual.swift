//
//  Error+AreEqual.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 28/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

// The following content is taken from Kandel Vijaya's blog: https://kandelvijaya.com/2018/04/21/blog_equalityonerror

// Long story short: comparing error types with associated values can be tricky
// In our case in particular, the APIError error type has an associated value of Swift.Error
// This means we can't simply compare lhs and rhs's associated values directly because it's pretty much an empty protocol
// We could rely on NSError instead; cast them both and compare them there but if the Swift.Error has an associated value itself then we can't because it's not representable in Swift

// Therefore, the `areEqual(_:_)` method deals with both cases

/**
 This is a equality on any 2 instance of Error.
 */
public func areEqual(_ lhs: Error, _ rhs: Error) -> Bool {
    return lhs.reflectedString == rhs.reflectedString
}


public extension Error {
    var reflectedString: String {
        // NOTE 1: We can just use the standard reflection for our case
        return String(reflecting: self)
    }
    
    // Same typed Equality
    public func isEqual(to: Self) -> Bool {
        return self.reflectedString == to.reflectedString
    }
    
}


public extension NSError {
    // prevents scenario where one would cast swift Error to NSError
    // whereby losing the associatedvalue in Obj-C realm.
    // (IntError.unknown as NSError("some")).(IntError.unknown as NSError)
    public func isEqual(to: NSError) -> Bool {
        let lhs = self as Error
        let rhs = to as Error
        return self.isEqual(to) && lhs.reflectedString == rhs.reflectedString
    }
}
