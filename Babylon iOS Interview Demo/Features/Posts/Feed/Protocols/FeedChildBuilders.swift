//
//  FeedChildBuilders.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

protocol FeedChildBuilders {
    func makeDetailedPost(
        modal: Flow,
        navigation: Flow
        ) -> UIViewController
}
