//
//  Store.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol Provider {
    func fetch() -> SignalProducer<Feed, FeedStore.Error>
}

final class FeedStore {
    
    enum Error: Swift.Error {
        case unknown
        case networkError
    }
    
    let networkLoader = FeedStore.Network()
    let database = FeedStore.Persistence()

    func load() -> SignalProducer<Feed, FeedStore.Error> {
    
        return networkLoader
            .fetch()
            .on(value: { [database] feed in
                database.store(items: feed)
            })
    }
    
    func load(post postId: Int) -> Post? {
        return Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")
    }
}

