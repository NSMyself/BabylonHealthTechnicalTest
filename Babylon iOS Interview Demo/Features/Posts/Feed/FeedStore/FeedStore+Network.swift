//
//  FeedStore+Network.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

extension FeedStore {
    
    struct Network: Provider {
        let api: API
        
        init() {
            self.api = API(session: .shared)
        }
        
        func fetch() -> SignalProducer<Feed, FeedStore.Error> {
            let parser = Parser<Feed>()
            
            return api
                .fetch(with: APIRequest(endpoint: .init(resource: .posts)))
                .flatMap(.latest, parser.transform)
                .mapError { _ in FeedStore.Error.networkError }
        }
    }
}
