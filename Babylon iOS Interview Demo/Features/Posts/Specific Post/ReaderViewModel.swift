//
//  ReaderViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 27/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

final class ReaderViewModel {
    
    private(set) var post: Post
    private let store: FeedStore
    
    init(with post: Post, store: FeedStore) {
        self.post = post
        self.store = store
    }
    
    var title: String {
        return post.title
    }
    
    var body: String {
        return post.body
    }
    
    func loadUser() -> SignalProducer<User, FeedStore.Error> {
        
        guard let userId = post.userId else {
            fatalError("FeedStore.Error.noUserId")
            // TESTAR ISTO
        }
        
        return store
            .loadUsers()
            .flatten()
            .filter { $0.id == userId }
    }
}

