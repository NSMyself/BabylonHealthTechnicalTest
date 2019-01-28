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
import os.log

public final class FeedStore {
    
    private let persistence = FeedStore.Persistence()
    private let network = FeedStore.Network()
    
    private let posts = MutableProperty<[Post]>([])
    private let users = MutableProperty<[User]>([])
    private let comments = MutableProperty<[Comment]>([])
    
    init() {
        posts
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] items in
                persistence.store(posts: items)
            }
        
        users
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] items in
                persistence.store(users: items)
        }
        
        comments
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] feed in
                persistence.store(comments: feed)
        }
    }
}

extension FeedStore {
    
    func loadPosts() -> SignalProducer<[Post], FeedStore.Error> {
    
        guard (posts.value.count == 0) else {
            return posts.producer.promoteError()
        }
        
        return network
            .fetchPosts()
            .flatMapError { [persistence] _ in persistence.fetchPosts() }
            .on(value: { [posts] feed in
                posts.value = feed
            })
    }
    
    func loadUsers() -> SignalProducer<[User], FeedStore.Error> {
        
        guard (users.value.count == 0) else {
            return users.producer.promoteError()
        }
        
        return network
            .fetchUsers()
            .flatMapError { [persistence] _ in persistence.fetchUsers() }
            .on(value: { [users] feed in
                users.value = feed
            })
    }
    
    func loadComments() -> SignalProducer<[Comment], FeedStore.Error> {
        
        guard (comments.value.count == 0) else {
            return comments.producer.promoteError()
        }
        
        return network
            .fetchComments()
            .flatMapError { [persistence] _ in persistence.fetchComments() }
            .on(value: { [comments] feed in
                comments.value = feed
            })
    }
    
    func loadComments(for postId: Post.Id) -> SignalProducer<[Comment], FeedStore.Error> {
        return loadComments()
            .map { comments in comments.filter { $0.postId == postId } }
    }
    
    func loadUser(with userId: User.Id)  -> SignalProducer<User, FeedStore.Error> {
        return loadUsers()
            .flatten()
            .filter { $0.id == userId }
    }
}
