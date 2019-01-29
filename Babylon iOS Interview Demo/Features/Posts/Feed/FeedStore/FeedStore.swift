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
    
    fileprivate let posts = MutableProperty<[Post]>([])
    fileprivate let users = MutableProperty<[User]>([])
    fileprivate let comments = MutableProperty<[Comment]>([])
    
    public let mode: Mode
    
    init(_ mode: Mode = .live) {
        
        self.mode = mode
        
        posts
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] items in
                guard mode == .live else { return }
                persistence.store(posts: items)
            }
        
        users
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] items in
                guard mode == .live else { return }
                persistence.store(users: items)
        }
        
        comments
            .producer
            .skipRepeats()
            .filter { $0.count > 0 }
            .startWithValues { [persistence] feed in
                guard mode == .live else { return }
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
            .mapError { FeedStoreError.persistence($0) }
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
            .mapError { FeedStoreError.persistence($0) }
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
            .mapError { FeedStoreError.persistence($0) }
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

// MARK: - Mock
extension FeedStore {
    
    func inject(mockUsers: [User]) {
        guard mode == .mock else { return }
        users.value = mockUsers
    }
    
    func inject(mockPosts: [Post]) {
        guard mode == .mock else { return }
        posts.value = mockPosts
    }
    
    func inject(mockComments: [Comment]) {
        guard mode == .mock else { return }
        comments.value = mockComments
    }
}
