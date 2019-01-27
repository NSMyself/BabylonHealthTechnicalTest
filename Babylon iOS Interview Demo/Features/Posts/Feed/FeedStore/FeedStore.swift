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
        case databaseError
        func log() {}
    }
    
    private let persistence = FeedStore.Persistence()
    private let network = FeedStore.Network()
    
    private let posts = MutableProperty<[Post]>([])

    init() {
        posts
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] feed in
                persistence.store(posts: feed)
            }
    }
    
    func loadPosts() -> SignalProducer<[Post], FeedStore.Error> {
    
        guard (posts.value.count == 0) else {
            return posts.producer.promoteError()
        }
        
        return network
            .fetchPosts()
            .flatMapError { [persistence] _ in persistence.fetch(resource: .posts) }
            .on(value: { [posts] feed in
                posts.value = feed
            })
    }
    
    func load(post postId: Int) -> Post? {
        return Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")
    }
}
