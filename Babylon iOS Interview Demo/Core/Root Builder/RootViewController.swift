//
//  RootViewController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class RootViewController: UITabBarController, UITabBarControllerDelegate {

    let viewModel: RootViewModel
    
    init(using viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setup()
    }
    
    private func setup() {
        self.viewControllers = viewModel.viewControllers
    }
}
