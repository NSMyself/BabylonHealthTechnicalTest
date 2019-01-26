//
//  URLRequest+APIRequest.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init?(from apiRequest: APIRequest) {
        
        guard let url = apiRequest.endpoint.url else {
            return nil
        }
        
        self.init(url: url)
        httpMethod = apiRequest.method.value
        if case let .post(data) = apiRequest.method {
            httpBody = data
        }
        
        apiRequest.headers.forEach { header in
            addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        timeoutInterval = apiRequest.timeoutInterval
        cachePolicy = apiRequest.cachePolicy
        
        setValue(apiRequest.contentType, forHTTPHeaderField: "Content-Type")
        setValue(apiRequest.contentType, forHTTPHeaderField: "Accept")
    }
}
