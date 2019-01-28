//
//  Requestable.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

protocol Requestable {
    var endpoint: Endpoint { get }
    var contentType: String { get }
    var kind: APIRequest.Kind { get }
    var headers: [String: String] { get }
}
