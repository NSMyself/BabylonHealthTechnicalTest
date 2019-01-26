//
//  Right Arrow.swift
//  Babylon iOS Interview Demo
//

import Foundation

// Originally seen in PointFree
// All credit goes to Stephen Celis and Brandon Williams

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in
        g(f(a))
    }
}
