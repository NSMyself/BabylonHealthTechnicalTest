//
//  Store.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

typealias StoreError = FeedViewModel.Store.Error

extension FeedViewModel {

    final class Store {
        
        enum Error: Swift.Error {
            case networkError
        }
        
        func fetch() -> SignalProducer<Feed, StoreError> {
            
            // mock data, for now
            let sp = SignalProducer<Feed, StoreError> { (observer, lifetime) in
                observer.send(value: [Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")])
                observer.sendCompleted()
            }
            
            return sp
        }
        
        func fetch(post postId: Int) -> Post? {
            return Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")
        }
    }
}

