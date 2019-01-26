//
//  Environment.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

enum Environment {
    case development
    case production
    
    var baseURL: URL? {
        switch self {
        case .development, .production:
            return URL(string: "http://jsonplaceholder.typicode.com")
        }
    }
}
