//
//  API+Error.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 28/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation

public typealias APIError = API.Error

extension API {
    
    public enum Error: LogRepresentable, Swift.Error {
        case error(Swift.Error)
        case invalidData
        case invalidResponse
        case invalidURL
        
        var rawValue: String {
            switch(self) {
            case .invalidData:
                return "Invalid data"
            case .invalidResponse:
                return "Invalid response"
            case .invalidURL:
                return "Invalid URL"
            case let .error(baseError):
                return baseError.localizedDescription
            }
        }
    }
}

extension APIError: Equatable {
    public static func == (lhs: API.Error, rhs: API.Error) -> Bool {
        switch (lhs, rhs) {
        case let (.error(e1), .error(e2)):
            return areEqual(e1, e2)
        case (.invalidData, .invalidData):
            return true
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        default:
            return false
        }
    }
}
