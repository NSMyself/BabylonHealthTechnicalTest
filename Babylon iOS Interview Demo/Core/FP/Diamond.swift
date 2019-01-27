//
//  Diamond.swift
//  Babylon iOS Interview Demo
//
// Originally seen in PointFree (https://www.pointfree.co)
// All credit goes to Stephen Celis and Brandon Williams
//

import Foundation

infix operator <>: SingleTypeComposition

func <> <A>(
    f: @escaping (A) -> A,
    g: @escaping (A) -> A)
    -> ((A) -> A) {
        
        return f >>> g
}
