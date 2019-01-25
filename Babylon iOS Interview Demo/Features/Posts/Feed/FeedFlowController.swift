//
//  FeedFlowController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift

class FeedFlowController {

    private let modalFlow: Flow
    private let navigationFlow: Flow
    private let builder: FeedBuilder
    private weak var delegate: FeedRenderDelegate?
    
    init(modal: Flow, navigation: Flow, builder: FeedBuilder, delegate: FeedRenderDelegate?) {
        self.modalFlow = modal
        self.navigationFlow = navigation
        self.builder = builder
        self.delegate = delegate
    }
}

extension FeedFlowController {
    func handle(_ route: FeedViewModel.Route) {
        switch route {
        case .showLoading():
            print("nay")
            delegate?.show(context: .placeholder(.loading))
        case let .showFeed(posts):
            print("hey")
            delegate?.show(context: .feed(posts))
        case let .showPost(post):
            print("SHOW POST \(post.body)") // trocoar por builder
        case let .showAlert(error):
            //renderer?.alert(error) // trocar por modal
            break
        }
    }
}
