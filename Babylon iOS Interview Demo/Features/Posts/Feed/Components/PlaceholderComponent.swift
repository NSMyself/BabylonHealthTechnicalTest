//
//  PlaceholderComponent.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Bento

final class PlaceholderComponent: Renderable {
    
    func render(in view: PlaceholderCell) {
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
