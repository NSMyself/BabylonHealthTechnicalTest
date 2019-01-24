//
//  AboutMeBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

struct AboutMeBuilder: Buildable {
    
    typealias T = AboutMeViewController
    
    func make() -> T {
        return T()
    }
}
