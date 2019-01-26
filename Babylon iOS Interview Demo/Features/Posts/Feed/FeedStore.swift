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

typealias StoreError = FeedViewModel.Store.Error

extension FeedViewModel {

    final class Store {
        
        let api: API
        
        init() {
            self.api = API(session: .shared)
        }
        
        enum Error: Swift.Error {
            case unknown
            case networkError
        }
        
        func fetch() -> SignalProducer<Feed, StoreError> {

            let parser = Parser<Feed>()
            
            return api
                .fetch(with: APIRequest(endpoint: .init(resource: .posts)))
                .flatMap(.latest, parser.transform)
                .mapError { _ in StoreError.networkError }
        }
        
        func fetch(post postId: Int) -> Post? {
            return Post(id: 3, userId: 3, title: "fdx", body: "ewijoi wejfoijfewoijfoiwef")
        }
    }
}
