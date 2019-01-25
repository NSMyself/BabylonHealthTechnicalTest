//
//  FeedViewModel+Reduce.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

extension FeedViewModel {
    
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .loading:
            return reduceLoading(state: state, event: event)
        case .loaded:
            return reduceLoaded(state: state, event: event)
        case let .loadingFailed(error):
            return reduceLoadingFailed(state: state, event: event, error: error)
        case let .showing(post):
            return reduceShow(state: state, event: event, post: post)
        }
    }
    
    static func reduceLoading(state: State, event: Event) -> State {
        switch event {
        case let .didFail(error):
            return .loadingFailed(error)
        case let .didLoad(posts):
            return .loaded(posts)
        case let .ui(.didSelect(post)):
            return .showing(post: post)
        default:
            return state
        }
    }
    
    static func reduceLoaded(state: State, event: Event) -> State {
        switch event {
        case let .ui(.didSelect(post)):
            return .showing(post: post)
        default:
            return state
        }
    }
    
    static func reduceLoadingFailed(state: State, event: Event, error: FeedViewModel.Store.Error) -> State { // NOT YET IMPLEMENTED
        switch event {
        case .ui(.retry):
            return .loading
        default:
            return state
        }
    }
    
    static func reduceShow(state: State, event: Event, post: Post) -> State {
        switch event {
        case .ui(.didSelect(post)):
            return .showing(post: post)
        default:
            return state
        }
    }
}
