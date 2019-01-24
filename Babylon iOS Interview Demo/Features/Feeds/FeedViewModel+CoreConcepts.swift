//
//  FeedViewModel+StateMachine.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

extension FeedViewModel {
    
    enum State {
        case loading
        case loaded([Post])
        case loadingFailed(FeedStore.Error)
        case showing(post: Post)
    }
    
    enum Event {
        case didLoad([Post])
        case didFail(FeedStore.Error)
        case ui(Action)
    }
    
    enum Action {
        case retry
        case didSelect(post: Post)
    }
    
    enum Route {
        case showLoading()
        case showFeed(feed: Feed)
        case showAlert(alert: FeedStore.Error)
        case showPost(_ post: Post)
    }
}

extension FeedViewModel.State: Equatable {
    static func == (lhs: FeedViewModel.State, rhs: FeedViewModel.State) -> Bool {
        switch(lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.loadingFailed, .loadingFailed):
            return true
        case let (.showing(post1), .showing(post2)):
            return post1 == post2
        default:
            return false
        }
    }
}
