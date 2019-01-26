//
//  UIViewController+Flow.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 21/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

extension UIViewController {
    
    struct ModalFlow: Flow {
        
        weak var viewController: UIViewController?
        
        init(viewController: UIViewController) {
            self.viewController = viewController
        }
        
        func present(_ viewController: UIViewController, animated: Bool) {
            self.viewController?.present(viewController, animated: animated, completion: nil)
        }
        
        func dismiss(animated: Bool) {
            self.viewController?.dismiss(animated: animated, completion: nil)
        }
    }
    
    var modalFlow: ModalFlow {
        return ModalFlow(viewController: self)
    }
}
