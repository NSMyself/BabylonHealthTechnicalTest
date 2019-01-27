//
//  Curry.swift
//  Babylon iOS Interview Demo
//
// Originally seen in PointFree (https://www.pointfree.co)
// All credit goes to Stephen Celis and Brandon Williams
//

import Foundation

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}
