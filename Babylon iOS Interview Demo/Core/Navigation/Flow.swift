//
//  Flow.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 21/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

protocol Flow {
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
}
