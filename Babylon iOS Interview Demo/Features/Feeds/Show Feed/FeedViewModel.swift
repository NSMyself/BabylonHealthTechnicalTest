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

enum StoreError: Error {
    case networkError
}

class Store {
    
    func fetch() -> Signal<[Post], NoError> {
        let (output, input) = Signal<[Post], NoError>.pipe()
        input.send(value: [])
        return output
    }
}

final class FeedViewModel {

    let store: Store
    let state: Property<State>
    let routes: Signal<Route, NoError>
    
    private let (actions, observer) = Signal<Action, NoError>.pipe()
    
    init(with store: Store) {
        
        self.store = store
        
        state = Property(
            initial: .loading,
            reduce: FeedViewModel.reduce,
            feedbacks: [
                FeedViewModel.whenLoading(using: store),
                FeedViewModel.whenFailed(),
                FeedViewModel.userActions(actions: actions)
            ]
        )
        
        routes = state
            .signal
            .skipRepeats()
            .filterMap { state in
                switch state {
                case let .loaded(posts, error): // TODO: ADD THIS: where posts.count > 0:
                    return .showFeed(feed: posts, error: error)
                case let .loadFailed(error):
                    return .showAlert(alert: error)
                default:
                    return nil
            }
        }
    }
}

extension FeedViewModel {
    
    func send(action: FeedViewModel.Action) {
        observer.send(value: action)
    }
    
    fileprivate static func userActions(actions: Signal<Action, NoError>) -> Feedback<State, FeedViewModel.Event> {
        return Feedback { scheduler, state -> Signal<Event, NoError> in
            return actions.map(Event.ui).observe(on: scheduler)
        }
    }
    
    fileprivate static func whenFailed() -> Feedback<State, FeedViewModel.Event> {
        return Feedback { state -> SignalProducer<Event, NoError> in
            return .empty
        }
    }
    
    fileprivate static func whenLoading(using store: Store)  -> Feedback<State, FeedViewModel.Event> {
        return Feedback { state -> Signal<Event, NoError> in
            guard case .loading = state else { return .empty }
            return store.fetch()
                .map(value: Event.didFail)
        }
    }
}

extension FeedViewModel {
    
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .loading:
            return reduceLoading(state: state, event: event)
        case let .loadFailed(error):
            return reduceLoadingFailed(state: state, event: event, error: error)
        case .loaded:
            return reduceLoading(state: state, event: event)
        case let .showing(post):
            return reduceShow(state: state, event: event, post: post)
        }
    }
    
    static func reduceLoading(state: State, event: Event) -> State {
        switch event {
        case let .didFail(error):
            return .loadingFailed(error)
        case let .didLoad(posts):
            return .loaded(posts, nil)
        default:
            return state
        }
    }
    
    static func reduceLoadingFailed(state: State, event: Event, error: StoreError) -> State { // NOT YET IMPLEMENTED
        switch event {
        //case .ui(.retry):
          //  return .loading
        default:
            return state
        }
    }
    
    static func reduceShow(state: State, event: Event, post: Post) -> State {
        switch event {
        case .ui(_): // NOTE: SINCE WE'VE ONLY ONE ACTION THERE'S ACTUALLY NO NEED TO USE IT HERE; KEEPING IT BECAUSE WE COULD DO OTHER ACTIONS (EG: BOOKMARK IT, ...)
            return .showing(post: post)
        default:
            return state
        }
    }
}

