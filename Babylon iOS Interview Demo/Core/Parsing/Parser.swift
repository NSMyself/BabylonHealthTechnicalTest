//
//  Parser.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import ReactiveSwift

func transform<T: Decodable>(data: Data?) -> SignalProducer<T, APIError> {
    return SignalProducer { observable, disposable in
        guard
            let data = data,
            let output = try? JSONDecoder().decode(T.self, from: data) else {
            observable.send(error: APIError.invalidData)
            return
        }

        observable.send(value: output)
        observable.sendCompleted()
    }
}

struct Parser<T: Decodable> {
    
    init() {}
    
    let transform: (Data?, URLResponse) -> SignalProducer<T, APIError> = { data, response in
        return SignalProducer { observable, disposable in
            
            guard let output = parse(data: data) else {
                observable.send(error: APIError.invalidData)
                return
            }
            
            observable.send(value: output)
            observable.sendCompleted()
        }
    }
    
    private static func parse(data: Data?) -> T? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
