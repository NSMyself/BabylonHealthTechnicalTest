//
//  TechTestUnitTesting.swift
//  TechTestUnitTesting
//
//  Created by João Pereira on 29/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import XCTest
@testable import TechTest

class TechTestUnitTesting: XCTestCase {
    
    var store: FeedStore!
    var reader: ReaderViewModel!
    
    override func setUp() {
        
        let post = Post(id: 1, userId: 1, title: "The Dream-Quest of Unknown Kadath", body: "Three times Randolph Carter dreamed of the marvellous city, and three times was he snatched away while still he paused on the high terrace above it.")
        
        let users = [
            User(id: 1, username: "yog", name: "Yog-Sothoth", email: "yog@outergods.com"),
            User(id: 2, username: "squid", name: "Cthulhu", email: "cthulhu@greatoldones.com"),
            User(id: 3, username: "ahtu", name: "Nyarlatothep", email:"crawlingchaos@outergods.com")
        ]
        
        let comments = [
            Comment(postId: 1, id: 1, name: "Wilbur Whateley", email: "wilbur@mail.telepac.pt", body: "I felt myself on the edge of the world; peering over the rim into a fathomless chaos of eternal night."),
            Comment(postId: 1, id: 2, name: "Francis Wayland Thurston", email: "francis@clix.pt", body: "Iä! Iä! Cthulhu fhtagn!")
        ]
        
        self.store = FeedStore(.mock)
        self.reader = ReaderViewModel(with: post, store: store)
        
        store.inject(mockPosts: [post])
        store.inject(mockUsers: users)
        store.inject(mockComments: comments)
    }
    
    func testUsername() {
        reader
            .loadUsername(of: 1)
            .startWithValues { username in
                assert(username == "by: Yog-Sothoth")
        }
    }
    
    func testComments() {
        reader
            .loadTotalComments(for: 1)
            .startWithValues { comments in
                assert(comments == "Total comments: 2")
            }
    }
}
