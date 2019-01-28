//
//  FeedStore+PersistenceProvider.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift
import os.log

public typealias PersistenceError = FeedStore.Persistence.Error

public extension FeedStore {
    
    public final class Persistence {
        
        public enum Error: String, Swift.Error {
            case documentDirectoryNotFound =  "Document directory not found"
            case noObjectsToStore = "No objects to store"
            case writeFailure = "Could not write to disk"
            case readFailure = "Could not read data from disk"
            case encodeFailure = "Could not encode objects"
            case decodeFailure = "Could not decode objects"
            case nullDataToEncode = "Trying to write null data to disk"
            case nullDataToDecode = "Trying to decode null data"
        }
    }
}

extension FeedStore.Persistence {
 
    // Unfortunately, I did not have enough time to build a unified fetch data transformation pipeline using function composition
    // It's a pity because we could avoid a lot of boilerplate...
    func fetchPosts() -> SignalProducer<[Post], PersistenceError> {
    
        return (Resource.posts.rawValue |> loadFromDisk)
            .map { [unowned self] data in data |> self.decodePosts }
            .flatten(.latest)
            .on(failed: { error in
                FeedStoreError.persistence(error).log()
            })
    }
    
    
    func fetchUsers() -> SignalProducer<[User], PersistenceError> {
        
        return (Resource.users.rawValue |> loadFromDisk)
            .map { [unowned self] data in data |> self.decodeUsers }
            .flatten(.latest)
            .on(failed: { error in
                FeedStoreError.persistence(error).log()
            })
    }
    
    func fetchComments() -> SignalProducer<[Comment], PersistenceError> {
        
        return (Resource.comments.rawValue |> loadFromDisk)
            .map { [unowned self] data in data |> self.decodeComments }
            .flatten(.latest)
            .on(failed: { error in
                FeedStoreError.persistence(error).log()
            })
    }
}

extension FeedStore.Persistence {

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

extension FeedStore.Persistence {
    
    private func loadFromDisk(filename: String) -> SignalProducer<Data, PersistenceError> {
        
        return SignalProducer<Data, PersistenceError> { observer, lifetime in
        
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                observer.send(error: .documentDirectoryNotFound)
                return
            }
            
            guard let data = try? Data(contentsOf: documentDirectory.appendingPathComponent("\(filename).data").absoluteURL) else {
                observer.send(error: .nullDataToDecode)
                return
            }
            
            observer.send(value: data)
        }
    }
    
    private  func decodePosts(data: Data) -> SignalProducer<[Post], PersistenceError> {
        return SignalProducer<[Post], PersistenceError> { observer, lifetime in
            guard let objects = try? JSONDecoder().decode([Post].self, from: data) else {
                observer.send(error: .decodeFailure)
                return
            }
            
            observer.send(value: objects)
        }
    }
    
    private  func decodeUsers(data: Data) -> SignalProducer<[User], PersistenceError> {
        return SignalProducer<[User], PersistenceError> { observer, lifetime in
            guard let objects = try? JSONDecoder().decode([User].self, from: data) else {
                observer.send(error: .decodeFailure)
                return
            }
            
            observer.send(value: objects)
        }
    }
    
    private  func decodeComments(data: Data) -> SignalProducer<[Comment], PersistenceError> {
        return SignalProducer<[Comment], PersistenceError> { observer, lifetime in
            guard let objects = try? JSONDecoder().decode([Comment].self, from: data) else {
                observer.send(error: .decodeFailure)
                return
            }
            
            observer.send(value: objects)
        }
    }
}

extension FeedStore.Persistence {
    
    private func encode<T: Encodable>(_ items: T) -> String? {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(items) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    private func encode<T: Encodable>(items: T) -> SignalProducer<String?, PersistenceError> {
        return SignalProducer<String?, PersistenceError> { [weak self] observer, lifetime in
            
            guard let encoded = self?.encode(items) else {
                observer.send(error: PersistenceError.encodeFailure)
                return
            }
            
            observer.send(value: encoded)
        }
    }
    
    private func storeToDisk(posts: String?) {
        storeToDisk(payload: posts, prefix: "posts")
    }
    
    private func storeToDisk(users: String?) {
        storeToDisk(payload: users, prefix: "users")
    }
    private func storeToDisk(comments: String?) {
        storeToDisk(payload: comments, prefix: "comments")
    }
    
    private func storeToDisk(payload: String?, prefix: String) {
        do {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                FeedStoreError.persistence(.documentDirectoryNotFound).log()
                return
            }
            
            guard let payload = payload else {
                FeedStoreError.persistence(.nullDataToEncode).log()
                return
            }
            
            let filename = documentDirectory.appendingPathComponent("\(prefix).data")
            try payload.write(to: filename, atomically: true, encoding: .utf8)
            os_log("✅ Successfully stored data to: %@", log: OSLog.storage, type: .info, filename.absoluteString)
        }
        catch {
            FeedStoreError.persistence(.writeFailure).log()
        }
    }
}

extension FeedStore.Persistence {
    
    fileprivate func validate<T>(_ objects: [T]) -> Bool {
        guard objects.count > 0 else {
            FeedStoreError.persistence(.noObjectsToStore).log()
            return false
        }
        
        return true
    }
}
