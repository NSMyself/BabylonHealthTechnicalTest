//
//  ReaderViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 27/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

public final class ReaderViewModel {
    
    private(set) var post: Post
    private let store: FeedStore
    
    var title: String {
        return "post_details".localized
    }
    
    var postTitle: String {
        return post.title
    }
    
    var postBody: String {
        return post.body
    }
    
    let username: MutableProperty<String> = MutableProperty("")
    let numberOfComments: MutableProperty<String> = MutableProperty("")
    
    init(with post: Post, store: FeedStore) {
        
        guard let userId = post.userId else {
            fatalError("UserId not found when opening post")
        }
        
        self.post = post
        self.store = store
        
        username <~ loadUsername(of: userId)
        numberOfComments <~ loadComments(for: post.id)
    }
    
    public func loadUsername(of userId: User.Id) -> SignalProducer<String, NoError> {
        return store
            .loadUser(with: userId)
            .take(first: 1)
            .map { "\("by".localized): \($0.name)" }
            .flatMapError { error -> SignalProducer<String, NoError> in
                return SignalProducer.empty
            }
    }
    
    public func loadComments(for postId: Post.Id) -> SignalProducer<String, NoError> {
        return store
            .loadComments(for: postId)
            .take(first: 1)
            .map { comments in
                comments
                .filter { $0.postId == postId}
                .count
            }
            .map { "\("total_comments".localized): \($0)" }
            .flatMapError { error -> SignalProducer<String, NoError> in
                return SignalProducer.empty
            }
    }
}
