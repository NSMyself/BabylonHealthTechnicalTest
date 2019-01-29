//
//  FeedStore+XCTestCase.swift
//  Babylon iOS Interview DemoTests
//
//  Created by João Pereira on 28/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift
import Tagged

extension FeedStore {
    
    func inject(mockUsers: [User]) {
        guard mode == .mock else { return }
        users.value = mockUsers
    }
    
    func inject(mockPosts: [Post]) {
        guard mode == .mock else { return }
        posts.value = mockPosts
    }
    
    func inject(mockComments: [Comment]) {
        guard mode == .mock else { return }
        comments.value = mockComments
    }
}
