//
//  FeedViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import Bento
import ReactiveSwift
import ReactiveFeedback
import Result

final class FeedViewModel {

    fileprivate let renderer:FeedViewModel.Renderer
    
    private let store: FeedStore
    let state: Property<State>
    
    let routes: Signal<Route, NoError>
    let box: Property<Box<Renderer.SectionId, Renderer.RowId>>
    
    var title: String {
        return "feed_tab_title".localized
    }
    
    init(with store: FeedStore) {
        
        self.store = store
        self.renderer = FeedViewModel.Renderer()
        
        box = Property(initial: .empty, then: renderer.signal)
        
        state = Property(
            initial: .loading,
            reduce: FeedViewModel.reduce,
            feedbacks: [
                FeedViewModel.actionsFeedback(actions: renderer.tapSignal),
                FeedViewModel.loadingFeedback(using: store),
                FeedViewModel.failedFeedback()
            ]
        )
        
        routes = state
            .signal
            .skipRepeats()
            .filterMap { state in
                switch state {
                case let .loaded(posts, _):
                    return .showFeed(feed: posts)
                case let .loadingFailed(error):
                    return .showAlert(alert: error)
                case let .showing(post):
                    return .showPost(post)
                case .closingPost:
                    return .closePost
                default:
                    return nil
                }
            }
    }
}

extension FeedViewModel {
    
    private static func loadingFeedback(using store: FeedStore)  -> Feedback<State, FeedViewModel.Event> {
        return Feedback { state -> SignalProducer<Event, NoError> in
            guard case .loading = state else { return .empty }
            
            return store.loadPosts()
                .map(Event.didLoad)
                .flatMapError { error in
                    SignalProducer(value: Event.didFail(error))
                }.observe(on: UIScheduler())
        }
    }
    
    private static func failedFeedback() -> Feedback<State, FeedViewModel.Event> {
        return Feedback { state -> SignalProducer<Event, NoError> in
            guard case let .loaded(posts, _?) = state else { return .empty }
            return SignalProducer(value: Event.didLoad(posts))
        }
    }
    
    private static func actionsFeedback(actions: Signal<Action, NoError>) -> Feedback<State, FeedViewModel.Event> {
        return Feedback { _ in
            return actions.map(Event.ui)
        }
    }
}

extension FeedViewModel: FeedRenderDelegate {
    
    func show(context: Context) {
        switch(context) {
        case let .placeholder(msg):
            renderer.render(placeholder: msg)
        case let .feed(posts):
            renderer.render(feed: posts)
        }
    }
    
    var isReadingPost: Bool {
        switch state.value {
        case .showing(post: _):
            return true
        default:
            return false
        }
    }
}
