//
//  RootViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class RootViewModel {
    
    let viewControllers: [UIViewController]
    
    init(with viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
