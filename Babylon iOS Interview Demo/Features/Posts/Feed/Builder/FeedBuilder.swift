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
    
    func make() -> UINavigationController {
        
        let store = FeedStore()
        let viewModel = FeedViewModel(with: store)
        let viewController = FeedViewController(with: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        
        let flowController = FeedFlowController(
            modal: viewController.modalFlow,
            navigation: navController.navigationFlow,
            builder: self,
            observer: viewModel.contextObserver
        )
        
        viewModel.routes
            .observe(on: UIScheduler())
            .observeValues(flowController.handle)
            
        return navController
    }
}

extension FeedBuilder: FeedChildBuilders {
    
    func makeReaderViewController(post: Post) -> UIViewController {
        let viewModel = ReaderViewModel(with: post, store: FeedStore())
        return ReaderViewController(with: viewModel)
    }
}
