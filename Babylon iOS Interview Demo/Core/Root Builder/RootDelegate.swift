//
//  RootDelegate.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

protocol RootDelegate: class {
    func build(using tab: TabRoute) -> UIViewController
}
