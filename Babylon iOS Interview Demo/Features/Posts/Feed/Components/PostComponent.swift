//
//  PostComponent.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Bento

final class PostComponent: Renderable {

    private let id: Int
    private let title: String
    private let description: String
    
    typealias View = PostCell
    
    init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
    func render(in view: PostCell) {
        view.id = id
        view.titleLabel.text = title
        view.descriptionLabel.text = description
    }
}
