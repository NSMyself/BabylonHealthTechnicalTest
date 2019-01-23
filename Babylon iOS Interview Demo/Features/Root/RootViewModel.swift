//
//  RootViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class RootViewModel {
    
    init() {}
    
    private let tabs:[TabRoute] = [.posts, .aboutMe]
    
    private func build(_ tab: TabRoute) -> UIViewController {
        
        switch(tab) {
        case .posts:
            let viewController = PostsViewController()
            viewController.tabBarItem = UITabBarItem(title: "Bookmarks", image: #imageLiteral(resourceName: "Posts"), selectedImage: #imageLiteral(resourceName: "Posts"))
            return viewController
            
        case .aboutMe:
            let viewController = AboutMeViewController()
            viewController.tabBarItem = UITabBarItem(title: "About me", image: #imageLiteral(resourceName: "About Me"), selectedImage: #imageLiteral(resourceName: "About Me"))
            return viewController
        }
    }
    
    lazy var viewControllers:[UIViewController] = {
        return tabs.map(build)
    }()
}
