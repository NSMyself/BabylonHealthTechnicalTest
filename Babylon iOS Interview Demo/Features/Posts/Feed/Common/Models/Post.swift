//
//  Post.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 24/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import Tagged

public struct Post: Codable, Hashable {
    let id: Id
    let userId: User.Id
    let title: String
    let body: String
    
    typealias Id = Tagged<Post, Int>
    typealias UserId = Tagged<User, Int>
}
