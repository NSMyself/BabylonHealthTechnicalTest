//
//  FeedStore+Error.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 28/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import os.log

typealias FeedStoreError = FeedStore.Error

extension FeedStore {
    public enum Error: Swift.Error, Loggable, LogRepresentable {
        case network(NetworkError)
        case persistence(PersistenceError)
        
        var rawValue: String {
            switch(self) {
            case let .network(error):
                return error.rawValue
            case let .persistence(error):
                return error.rawValue
            }
        }
        
        func log() {
            os_log("💥 Persistence error: %@", log: OSLog.storage, type: .error, rawValue)
        }
    }
}
extension FeedStore.Error: Equatable {
    public static func == (lhs: FeedStore.Error, rhs: FeedStore.Error) -> Bool {
        switch (lhs, rhs) {
        case let (.network(error1), .network(error2)):
            return error1 == error2
        case let(.persistence(error1), .persistence(error2)):
            return error1 == error2
        default:
            return false
        }
    }
}
