//
//  Babylon_iOS_Interview_DemoTests.swift
//  Babylon iOS Interview DemoTests
//
//  Created by João Pereira on 18/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import XCTest
@testable import Pods_Babylon_iOS_Interview_Demo

class Babylon_iOS_Interview_DemoTests: XCTestCase {

    let store: FeedStore
    let reader: ReaderViewModel
    
    override func setUp() {
        
        let test_mockPosts = [
            Post(id: 1, userId: 1, title: "Mock title", body: "Mock body"),
            Post(id: 2, userId: 1, title: "Mock title", body: "Mock body"),
            Post(id: 3, userId: 1, title: "Mock title", body: "Mock body")
        ]

        let users = [
            User(id: 1, username: "yog", name: "Yog-Sothoth", email: "yog@outergods.com"),
            User(id: 2, username: "squid", name: "Cthulhu", email: "cthulhu@greatoldones.com"),
            User(id: 3, username: "ahtu", name: "Nyarlatothep", email:"crawlingchaos@outergods.com")
        ]
        
        let comments = [
            Comment(postId: 1, id: 1, name: "Wilbur Whateley", email: "wilbur@telepac.pt", body: "bla bla bla bla")
        ]
        
        self.store = FeedStore(.mock)
        self.reader = ReaderViewModel(with: test_mockPosts.first!, store: store)
    }

    func testUsername() {
            reader
                .loadUsername(of: 1)
                .startWithValues { username in
                    assert(username == "Yog-Sothoth")
                }
    }
}
