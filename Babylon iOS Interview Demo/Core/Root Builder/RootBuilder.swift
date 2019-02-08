//
//  RootBuilder.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

public final class RootBuilder {
    
    private weak var window: UIWindow?
    
    private let feedBuilder: FeedBuilder
    private let aboutMeBuilder: AboutMeBuilder
    
    private let tabs: [Tab] = [
        Tab(
            route: .posts,
            item: TabItem(title: "feed_tab_title".localized, image: #imageLiteral(resourceName: "Posts"), selectedImage: #imageLiteral(resourceName: "Posts"))
        ),
        Tab(
            route: .aboutMe,
            item: TabItem(title: "about_tab_title".localized, image: #imageLiteral(resourceName: "About Me"), selectedImage: #imageLiteral(resourceName: "About Me"))
        )
    ]
    
    init(using window: UIWindow?) {
        self.window = window
        self.feedBuilder = FeedBuilder()
        self.aboutMeBuilder = AboutMeBuilder()
    }

    func run() {
        window?.rootViewController = make()
        window?.makeKeyAndVisible()
    }
}

extension RootBuilder {
    
    func make() -> RootViewController {
        return RootViewController(using: RootViewModel(with: tabs.map(build)))
    }
    
    func build(using tab: Tab) -> UIViewController {
        
        func makeNavController() -> UINavigationController {
            switch(tab.route) {
            case .posts:
                return feedBuilder.make()

            case .aboutMe:
                return aboutMeBuilder.make()
            }
        }
        
        let navigationController = makeNavController()
        navigationController.viewControllers.first?.tabBarItem = UITabBarItem(with: tab.item)
        
        return navigationController
    }
}

