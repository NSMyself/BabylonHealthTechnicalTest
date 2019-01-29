//
//  User.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 27/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Tagged

public struct User: Codable, Hashable {
    let id: Id
    let username: String
    let name: String
    let email: Email
    
    public typealias Id = Tagged<User, Int>
    public typealias Email = Tagged<User, String>
}
