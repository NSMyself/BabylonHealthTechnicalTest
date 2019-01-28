//
//  API.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift

public final class API {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(with apiRequest: APIRequest) -> SignalProducer<(Data?, URLResponse), APIError> {
        
        return SignalProducer { [session] observer, lifetime in
     
            guard let request = URLRequest(from: apiRequest) else {
                observer.send(error: .invalidURL)
                return
            }
            
            let dataTask = session.dataTask(with: request) { data, urlResponse, error in
                
                guard error == nil else {
                    
                    guard let error = error else {
                        fatalError("Will never happen; just avoiding force-unwrapping")
                    }
                    
                    observer.send(error: .error(error))
                    return
                }
                
                guard let data = data else {
                    observer.send(error: .invalidData)
                    return
                }
                
                guard let urlResponse = urlResponse else {
                    observer.send(error: .invalidResponse)
                    return
                }
                
                observer.send(value: (data, urlResponse))
                observer.sendCompleted()
            }
            
            dataTask.resume()
            lifetime.observeEnded { dataTask.cancel() }
        }
    }
}
