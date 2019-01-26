//
//  AboutMeBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

struct AboutMeBuilder: Buildable {
    
    typealias T = UINavigationController
    
    func make() -> T {
        let vc = AboutMeViewController()
        return UINavigationController(rootViewController: vc)
    }
}
