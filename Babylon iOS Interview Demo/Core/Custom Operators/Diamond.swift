//
//  Diamond.swift
//  Babylon iOS Interview Demo
//

import Foundation

// Originally seen in PointFree
// All credit goes to Stephen Celis and Brandon Williams
infix operator <>: SingleTypeComposition

func <> <A>(
    f: @escaping (A) -> A,
    g: @escaping (A) -> A)
    -> ((A) -> A) {
        
        return f >>> g
}
