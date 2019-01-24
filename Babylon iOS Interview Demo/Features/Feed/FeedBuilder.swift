//
//  FeedBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit
import ReactiveSwift

struct FeedBuilder: Buildable {
    
    typealias T = FeedViewController
    
    init() {}
    
    func make() -> T {
        let viewModel = FeedViewModel()
        
        let viewController = FeedViewController()
        
        let flowController = FeedFlowController(
            modal: viewController.modalFlow,
            navigation: viewController.modalFlow
        )
        
        /*viewModel.routes
            .observe(on: UIScheduler())
            .observeValues(flowController.handle)*/
        
        return viewController
    }
}
