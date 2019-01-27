//
//  PrecedenceGroups.swift
//  Babylon iOS Interview Demo
//
// Originally seen in PointFree (https://www.pointfree.co)
// All credit goes to Stephen Celis and Brandon Williams
//

import Foundation

precedencegroup ForwardApplication {
    associativity: left
}

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup BackwardsComposition {
    associativity: left
}
