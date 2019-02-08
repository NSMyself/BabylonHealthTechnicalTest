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
    private let observer: Signal<Context, NoError>.Observer

    init(modal: Flow, navigation: Flow, builder: FeedBuilder, observer: Signal<Context, NoError>.Observer) {
        self.modalFlow = modal
        self.navigationFlow = navigation
        self.builder = builder
        self.observer = observer
    }
}

extension FeedFlowController {
    func handle(_ route: FeedViewModel.Route) {
        switch route {
        case .showLoading:
            observer.send(value: .placeholder(.loading))
        case let .showFeed(posts):
            observer.send(value: .feed(posts))
        case let .showPost(post):
            navigationFlow.present(builder.makeReaderViewController(post: post), animated: true)
        case let .showAlert(error):
            modalFlow.present(UIAlertController.make(using: error), animated: true)
            break
        case .closePost:
            observer.send(value: .placeholder(.loading))
        }
    }
}
