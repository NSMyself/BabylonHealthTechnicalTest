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
    
    let endpoint: Endpoint
    let method: HttpMethod<Data>
    let contentType: String
    let kind: APIRequest.Kind
    let headers: [String: String]
    let timeoutInterval: TimeInterval
    let cachePolicy: URLRequest.CachePolicy
    
    init(endpoint: Endpoint,
         method: HttpMethod<Data> = .get,
         contentType: String = "application/json",
         kind: APIRequest.Kind = .plain,
         headers: [String: String] = [:],
         timeoutInterval: TimeInterval = 60,
         cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) {
        
        self.endpoint = endpoint
        self.method = method
        self.contentType = contentType
        self.kind = kind
        self.headers = headers
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = cachePolicy
    }
}

