//
//  PrecedenceGroups.swift
//  Babylon iOS Interview Demo
//

import Foundation

// Originally seen in PointFree
// All credit goes to Stephen Celis and Brandon Williams

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
