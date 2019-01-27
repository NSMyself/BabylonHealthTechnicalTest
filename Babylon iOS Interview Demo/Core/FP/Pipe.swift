//
//  Pipe.swift
//  Babylon iOS Interview Demo
//
// Originally seen in PointFree (https://www.pointfree.co)
// All credit goes to Stephen Celis and Brandon Williams
//

import Foundation

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}
