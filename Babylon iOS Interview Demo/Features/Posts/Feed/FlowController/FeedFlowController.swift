//
//  FeedFlowController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift

final class FeedFlowController {

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
            delegate?.show(context: .placeholder(.loading))
        case let .showFeed(posts):
            delegate?.show(context: .feed(posts))
        case let .showPost(post):
            navigationFlow.present(builder.makeReaderViewController(post: post), animated: true)
        case let .showAlert(error):
            modalFlow.present(UIAlertController.make(using: error), animated: true)
            break
        case .closePost:
            delegate?.show(context: .placeholder(.loading))
        }
    }
}
