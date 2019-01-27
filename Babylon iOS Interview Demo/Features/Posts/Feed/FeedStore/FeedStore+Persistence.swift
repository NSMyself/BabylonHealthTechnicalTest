//
//  FeedStore+PersistenceProvider.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift
import os.log

protocol Provider {
    func fetch(resource: Endpoint.Resource) -> SignalProducer<[Post], FeedStore.Error>
}

extension FeedStore {
    
    final class Persistence: Provider {
        
        enum PersistenceError: Swift.Error, Loggable {
            case documentDirectoryNotFound
            case noObjectsToStore
            case writeFailure
            case readFailure
            case encodeFailure
            case decodeFailure
            case nullDataToEncode
            
            func log() {
                switch(self) {
                case .documentDirectoryNotFound:
                    os_log("💥 Persistence error: Document directory not found", log: OSLog.storage, type: .error)
                case .writeFailure:
                    os_log("💥 Persistence error: Could not write to disk", log: OSLog.storage, type: .error)
                case .readFailure:
                    os_log("💥 Persistence error: Could not read data from disk", log: OSLog.storage, type: .error)
                case .encodeFailure:
                    os_log("💥 Persistence error: Could not serialize data", log: OSLog.storage, type: .error)
                case .decodeFailure:
                    os_log("💥 Persistence error: Could not decode objects from data", log: OSLog.storage, type: .error)
                case .noObjectsToStore:
                    os_log("💥 Persistence error: No objects to be stored", log: OSLog.storage, type: .error)
                case .nullDataToEncode:
                    os_log("💥 Persistence error: Trying to write null data to disk", log: OSLog.storage, type: .error)
                }
            }
        }
        
        func fetch(resource: Endpoint.Resource) -> SignalProducer<[Post], FeedStore.Error> {
            
            return SignalProducer<[Post], FeedStore.Error> { [weak self] observer, lifetime in
                
                guard let posts:[Post] = self?.decode(data: self?.loadFromDisk()) else {
                    observer.send(error: FeedStore.Error.databaseError)
                    return
                }
                
                observer.send(value: posts)
            }
        }
        
        func store(posts objects: [Post]) {
            guard validate(objects) else { return }
            objects |> encode >>> storeToDisk(posts:)
        }
        
        func store(users objects: [User]) {
            guard validate(objects) else { return }
            objects |> encode >>> storeToDisk(users:)
        }
        
        func store(comments objects: [Comment]) {
            guard validate(objects) else { return }
            objects |> encode >>> storeToDisk(comments:)
        }
    }
}

extension FeedStore.Persistence {
    
    private func loadFromDisk() -> Data? {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            PersistenceError.documentDirectoryNotFound.log()
            return nil
        }
        
        do {
            return try Data(contentsOf: documentDirectory.appendingPathComponent("posts.data").absoluteURL)
        }
        catch {
            PersistenceError.decodeFailure.log()
        }
        
        return nil
    }
    
    private  func decode<T: Decodable>(data: Data?) -> T? {
        
        guard let data = data else {
            PersistenceError.readFailure.log()
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            PersistenceError.decodeFailure.log()
        }
        
        return nil
    }
}

extension FeedStore.Persistence {
    
    private func encode<T: Encodable>(items: T) -> String? {
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(items)
            return String(data: data, encoding: .utf8)
        }
        catch {
            PersistenceError.encodeFailure.log()
        }
        
        return nil
    }
    
    private func storeToDisk(posts: String?) {
        storeToDisk(payload: posts, filename: "posts")
    }
    
    private func storeToDisk(users: String?) {
        storeToDisk(payload: users, filename: "comments")
    }
    private func storeToDisk(comments: String?) {
        storeToDisk(payload: comments, filename: "comments")
    }
    
    private func storeToDisk(payload: String?, filename: String) {
        do {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                PersistenceError.documentDirectoryNotFound.log()
                return
            }
            
            guard let payload = payload else {
                PersistenceError.nullDataToEncode.log()
                return
            }
            
            try payload.write(to: documentDirectory.appendingPathComponent("\(filename).data"), atomically: true, encoding: .utf8)
        }
        catch {
            PersistenceError.writeFailure.log()
        }
    }
}

extension FeedStore.Persistence {
    
    fileprivate func validate<T>(_ objects: [T]) -> Bool {
        guard objects.count > 0 else {
            PersistenceError.noObjectsToStore.log()
            return false
        }
        
        return true
    }
}
