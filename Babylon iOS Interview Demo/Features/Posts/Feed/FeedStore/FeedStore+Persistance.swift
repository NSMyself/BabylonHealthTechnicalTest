//
//  FeedStore+PersistenceProvider.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

extension FeedStore {
    
    struct Persistence: Provider {
        func fetch() -> SignalProducer<Feed, FeedStore.Error> {
            return .empty
        }
        
        func store<T>(items: T) {
            print(items as! Feed)
        }
    }
}
