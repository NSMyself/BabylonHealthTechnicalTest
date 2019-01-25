//
//  FeedBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit
import ReactiveSwift

struct FeedBuilder {
    
    init() {}
    
    func make() -> UIViewController {
        
        let store = FeedViewModel.Store()
        let viewModel = FeedViewModel(with: store)
        let viewController = FeedViewController(with: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let flowController = FeedFlowController(
            modal: viewController.modalFlow,
            navigation: navigationController.navigationFlow,
            builder: self,
            delegate: viewModel
        )
        
        viewModel.routes
            .observe(on: UIScheduler())
            .observeValues(flowController.handle)
        
        return viewController
    }
}

extension FeedBuilder: FeedChildBuilders {
    func makeDetailedPost(modal: Flow, navigation: Flow) -> UIViewController {
        return UIViewController()
    }
}
