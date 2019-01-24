//
//  FeedViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveFeedback
import Result

final class FeedViewModel {

    let store: FeedStore
    let state: Property<State>
    let routes: Signal<Route, NoError>
    
    private let (actions, observer) = Signal<Action, NoError>.pipe()
    
    init(with store: FeedStore) {
        
        self.store = store
        
        state = Property(
            initial: .loading,
            reduce: FeedViewModel.reduce,
            feedbacks: [
                FeedViewModel.loadingFeedback(using: store),
                FeedViewModel.actionsFeedback(actions: actions),
                FeedViewModel.failedFeedback(),
            ]
        )
        
        routes = state
            .signal
            .skipRepeats()
            .filterMap { state in
                switch state {
                case let .loaded(posts): // TODO: ADD THIS: where posts.count > 0:
                    return .showFeed(feed: posts)
                case let .loadingFailed(error):
                    return .showAlert(alert: error)
                case let .showing(post):
                    return .showPost(post)
                default:
                    return nil
            }
        }
    }
    
    func send(action: FeedViewModel.Action) {
        observer.send(value: action)
    }
}

extension FeedViewModel {
    
    private static func loadingFeedback(using store: FeedStore)  -> Feedback<State, FeedViewModel.Event> {
        return Feedback { state -> SignalProducer<Event, NoError> in
            guard case .loading = state else { return .empty }
            
            return store.fetch()
                .map(Event.didLoad)
                .flatMapError { error in
                    SignalProducer(value: Event.didFail(error))
                }.observe(on: UIScheduler())
        }
    }
    
    private static func failedFeedback() -> Feedback<State, FeedViewModel.Event> {
        return Feedback { state -> SignalProducer<Event, NoError> in
            return .empty
        }
    }
    
    private static func actionsFeedback(actions: Signal<Action, NoError>) -> Feedback<State, FeedViewModel.Event> {
        return Feedback { scheduler, state -> Signal<Event, NoError> in
            return actions.map(Event.ui).observe(on: scheduler)
        }
    }
}
