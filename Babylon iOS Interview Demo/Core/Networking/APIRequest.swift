//
//  BusinessAPI.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

public struct APIRequest {

    public enum Resource: String {
        case posts
        case users
        case comments
    }
    
    let environment: Environment
    let resource: Resource
    
    init(resource: Resource, in environment: Environment) {
        self.environment = environment
        self.resource = resource
    }
    
    var url: URL? {
        return environment.baseURL?.appendingPathComponent(resource.rawValue)
    }
}

public protocol Requestable {
    var endpoint: APIRequest { get }
    var kind: Request.Kind { get }
    var headers: [String: String] { get }
}

public struct Request: Requestable {
    
    public enum Kind {
        case plain
        case withParameters(JSONDictionary)
        case withEncodable(Encodable)
    }
    
    public let endpoint: APIRequest
    public let kind: Request.Kind
    public let headers: [String: String]
}

