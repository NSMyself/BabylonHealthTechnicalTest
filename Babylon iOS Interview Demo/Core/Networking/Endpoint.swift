//
//  Endpoint.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

public struct Endpoint {

    public enum Resource: String {
        case posts
        case users
        case comments
    }
    
    let environment: APIEnvironment
    let resource: Resource
    
    init(resource: Resource, in environment: APIEnvironment = .production) {
        self.environment = environment
        self.resource = resource
    }
    
    var url: URL? {
        return environment.baseURL?.appendingPathComponent(resource.rawValue)
    }
}
