//
//  FeedStore.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveFeedback

import ReactiveSwift
import Result

class FeedStore {
    
    enum Error: Swift.Error {
        case networkError
    }
    
    func fetch() -> SignalProducer<[Post], FeedStore.Error> {
        
        let sp = SignalProducer<[Post], FeedStore.Error> { (observer, lifetime) in
            observer.send(value: [Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")])
            observer.sendCompleted()
        }
        
        return sp
    }
}
