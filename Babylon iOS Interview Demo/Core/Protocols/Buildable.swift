//
//  Buildable.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

protocol Buildable {
    associatedtype T: UIViewController
    func make() -> T
}