//
//  RootBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

struct RootBuilder: Buildable {
    
    typealias T = RootViewController
    
    func make() -> T {
        return RootViewController(using: RootViewModel())
    }
}
