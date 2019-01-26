//
//  Pipe.swift
//  Babylon iOS Interview Demo
//

import Foundation

// Originally seen in PointFree
// All credit goes to Stephen Celis and Brandon Williams

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}
