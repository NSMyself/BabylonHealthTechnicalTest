//
//  Comment.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 27/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Tagged

public struct Comment: Codable, Hashable {
    let postId: Post.Id?
    let id: Id
    let name: String
    let email: String
    let body: String
    
    public typealias Id = Tagged<Comment, Int>
}
