//
//  Sequence+keyPathToGetter.swift
//  Babylon iOS Interview Demo
//
//  Copyright © 2019 NSMyself. All rights reserved.
//

// Originally seen in PointFree episode 8
// All credit goes to Stephen Celis and Brandon Williams
import Foundation

extension Sequence {
    func map<Value>(_ kp: KeyPath<Element, Value>) -> [Value] {
        return self.map { $0[keyPath: kp] }
    }
}
