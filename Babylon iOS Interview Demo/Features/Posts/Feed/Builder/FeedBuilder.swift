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
            delegate: viewModel
        )
        
        viewModel.routes
            .observe(on: UIScheduler())
            .observeValues(flowController.handle)
            
        return navController
    }
}

extension FeedBuilder: FeedChildBuilders {
    func makeReaderViewController(post postId: Int) -> UIViewController {
        guard let post = FeedStore().loadSpecific(post: postId) else { fatalError("💥 Invalid post ID!") }
        return ReaderViewController(using: post)
    }
}
