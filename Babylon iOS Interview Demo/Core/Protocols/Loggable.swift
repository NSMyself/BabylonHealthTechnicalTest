//
//  Loggable.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

protocol LogRepresentable {
    var rawValue: String { get }
}

protocol Loggable {
    func log()
}
