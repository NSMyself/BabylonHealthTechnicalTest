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

final class FeedStore {
    
    enum Error: Swift.Error, Loggable {
        case networkError
        func log() {}
    }
    
    private let database = FeedStore.Persistence()
    private let network = FeedStore.Network()
    
    private let posts = MutableProperty<[Post]>([])

    init() {
        posts
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [database] feed in
                database.store(posts: feed)
            }
    }
    
    func loadPosts() -> SignalProducer<[Post], FeedStore.Error> {
    
        return network
            .fetchPosts()
            .on(value: { [posts] feed in
                posts.value = feed
            })
    }
    
    func load(post postId: Int) -> Post? {
        return Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")
    }
}
