//
//  RootViewModel.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class RootViewModel {
    
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
    
    weak var delegate: RootDelegate?
    
    init(delegate: RootDelegate?) {
        self.delegate = delegate
    }
    
    private func build(_ tab: Tab) -> UIViewController? {
        let vc = delegate?.build(using: tab.route)
        vc?.tabBarItem = UITabBarItem(with: tab.item)
        return vc
    }
    
    lazy var viewControllers: [UIViewController] = {
        return tabs
            .compactMap(build)
    }()
}
