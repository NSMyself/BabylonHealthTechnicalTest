//
//  UINavigationController+ModalFlow.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 21/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    private struct NavigationFlow: Flow {
        
        weak var navigationController: UINavigationController?
        
        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
        func present(_ viewController: UIViewController, animated: Bool) {
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
        
        func dismiss(animated: Bool) {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    var navigationFlow: Flow {
        return NavigationFlow(navigationController: self)
    }
}
