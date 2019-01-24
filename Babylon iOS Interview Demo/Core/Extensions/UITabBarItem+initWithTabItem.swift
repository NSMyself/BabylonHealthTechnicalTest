//
//  UITabBarItem+make.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 23/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

extension UITabBarItem {
    convenience init(with item: TabItem) {
        self.init(title: item.title, image: item.image, selectedImage: item.selectedImage)
    }
}

