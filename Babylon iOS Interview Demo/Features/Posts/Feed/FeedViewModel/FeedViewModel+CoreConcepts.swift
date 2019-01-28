//
//  FeedViewModel+StateMachine.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

extension FeedViewModel {
    
    enum State: Equatable {        
        case loading
        case loaded([Post], FeedStore.Error?)
        case loadingFailed(FeedStore.Error)
        case showing(post: Post)
        case closingPost
    }
    
    enum Event: Equatable {
        case didLoad([Post])
        case didFail(FeedStore.Error)
        case ui(Action)
    }
    
    enum Action: Equatable {
        case didSelect(post: Post)
        case didClosePost
        case retry
    }
    
    enum Route {
        case showLoading()
        case showFeed(feed: [Post])
        case showAlert(alert: FeedStore.Error)
        case showPost(_ post: Post)
        case closePost
    }
}
