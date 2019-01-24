//
//  RootBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class RootBuilder {
    
    private weak var window: UIWindow?
    
    let feedBuilder: FeedBuilder
    let aboutMeBuilder: AboutMeBuilder
    
    init(using window: UIWindow?) {
        self.window = window
        self.feedBuilder = FeedBuilder()
        self.aboutMeBuilder = AboutMeBuilder()
    }

    func run() {
        window?.rootViewController = make(using: self)
        window?.makeKeyAndVisible()
    }
}

extension RootBuilder: RootDelegate {

    func make(using delegate: RootDelegate) -> RootViewController {
        return RootViewController(using: RootViewModel(delegate: delegate))
    }
    
    func build(using tab: TabRoute) -> UIViewController {
        
        switch(tab) {
        case .posts:
            return feedBuilder.make()

        case .aboutMe:
            return aboutMeBuilder.make()
        }
    }
}
