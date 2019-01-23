//
//  RootFlowController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 21/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class RootFlowController {
    
    private weak var window: UIWindow?
    private let builder: RootBuilder
    
    init(using window: UIWindow?) {
        self.window = window
        self.builder = RootBuilder()
    }
    
    func start() {
        window?.rootViewController = builder.make()
        window?.makeKeyAndVisible()
    }
}

