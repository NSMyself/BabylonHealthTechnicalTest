//
//  UIAlertController+makeError.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 27/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func make(using error: Error) -> UIAlertController {
        
        let actionController = UIAlertController(title: "error".localized,
                                                 message: error.localizedDescription,
                                                 preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "ok".localized, style: .default)
        actionController.addAction(submitAction)
        
        return actionController
    }
}
