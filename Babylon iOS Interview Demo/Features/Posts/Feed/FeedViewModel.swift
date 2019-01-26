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

    private let store: FeedViewModel.Store
    private let state: Property<State>
    let routes: Signal<Route, NoError>
    
    fileprivate let renderer:FeedViewModel.Renderer
    private let (actions, observer) = Signal<Action, NoError>.pipe()
    
    let box: Property<Box<Renderer.SectionId, Renderer.RowId>>
    
    init(with store: FeedViewModel.Store) {
        
        self.store = store
        self.renderer = FeedViewModel.Renderer()
        
        box = Property(initial: .empty, then: renderer.signal)
        
        state = Property(
            initial: .loading,
            reduce: FeedViewModel.reduce,
            feedbacks: [
                FeedViewModel.loadingFeedback(using: store),
                FeedViewModel.actionsFeedback(actions: actions),
                FeedViewModel.failedFeedback()
            ]
        )
        
        routes = state
            .signal
            .skipRepeats()
            .filterMap { state in
                switch state {
                case let .loaded(posts):
                    return .showFeed(feed: posts)
                case let .loadingFailed(error):
                    return .showAlert(alert: error)
                case let .showing(post):
                    return .showPost(post)
                default:
                    return nil
                }
            }
        
        renderer
            .tapSignal
            .observe(on: UIScheduler())
            .observeValues(send)
    }
    
    func send(action: FeedViewModel.Action) {
        observer.send(value: action)
    }
}

extension FeedViewModel {
    
    private static func loadingFeedback(using store: FeedViewModel.Store)  -> Feedback<State, FeedViewModel.Event> {
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
            guard case let .loaded(posts) = state else { return .empty }
            return SignalProducer(value: Event.didLoad(posts))
        }
    }
    
    private static func actionsFeedback(actions: Signal<Action, NoError>) -> Feedback<State, FeedViewModel.Event> {
        return Feedback { scheduler, state -> Signal<Event, NoError> in
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
}
