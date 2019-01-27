//
//  Right Arrow.swift
//  Babylon iOS Interview Demo
//
// Originally seen in PointFree (https://www.pointfree.co)
// All credit goes to Stephen Celis and Brandon Williams
//

import Foundation

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in
        g(f(a))
    }
}
