//
//  APIRequest.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

public struct APIRequest: Requestable {
    
    public enum Kind {
        case plain
        case withParameters(JSONDictionary)
        case withEncodable(Encodable)
    }
    
    public let endpoint: Endpoint
    public let method: HttpMethod
    public let kind: Request.Kind
    public let headers: [String: String]
}

