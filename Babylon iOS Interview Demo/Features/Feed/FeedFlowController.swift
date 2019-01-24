//
//  FeedFlowController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Foundation
import ReactiveSwift

class FeedFlowController {
    
    private let modalFlow: Flow
    private let navigationFlow: Flow
    
    init(modal: Flow, navigation: Flow) {
        self.modalFlow = modal
        self.navigationFlow = navigation
    }
    
    func observe(_ output: Signal<FeedRoute, NoError>) {
        
    }
}
