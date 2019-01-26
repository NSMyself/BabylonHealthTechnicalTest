//
//  HttpMethod.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

public enum HttpMethod<Body> {
    case get
    case post(Body)
    case put
    case delete
    case head
    case patch
    case trace
    case connect
}

extension HttpMethod {
    
    var value: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        case .head: return "HEAD"
        case .patch: return "PATCH"
        case .trace: return "TRACE"
        case .connect: return "CONNECT"
        }
    }
}
