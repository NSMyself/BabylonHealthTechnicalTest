//
//  FeedStore+Network.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift
import os.log

extension FeedStore {
    
    final class Network {
        
        func fetchPosts() -> SignalProducer<[Post], FeedStore.Error> {
            return API()
                .fetch(with: APIRequest(endpoint: .init(resource: .posts)))
                .retry(upTo: 3)
                .flatMap(.latest, Parser<[Post]>().transform)
                .mapError { _ in FeedStore.Error.networkError }
        }
        
        func fetchComments() -> SignalProducer<[Comment], FeedStore.Error> {
            return API()
                .fetch(with: APIRequest(endpoint: .init(resource: .comments)))
                .retry(upTo: 3)
                .flatMap(.latest, Parser<[Comment]>().transform)
                .mapError { _ in FeedStore.Error.networkError }
        }
        
        func fetchUsers() -> SignalProducer<[User], FeedStore.Error> {
            return API()
                .fetch(with: APIRequest(endpoint: .init(resource: .users)))
                .retry(upTo: 3)
                .flatMap(.latest, Parser<[User]>().transform)
                .mapError { _ in FeedStore.Error.networkError }
        }
    }
}

