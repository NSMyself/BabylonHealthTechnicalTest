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
        case loaded([Post], StoreError?)
        case loadFailed(StoreError)
        case showing(post: Post)
    }
    
    enum Event {
        case didLoad([Post], StoreError?)
        case didFail
        case ui(Action)
    }
    
    enum Action {
        case didSelect(post: Post)
    }
    
    enum Route {
        case showLoading()
        case showFeed(feed: Feed, error: Error?)
        case showAlert(alert: Error)
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
        case (.loadFailed, .loadFailed):
            return true
        case let (.showing(post1), .showing(post2)):
            return post1 == post2
        default:
            return false
        }
    }
}
