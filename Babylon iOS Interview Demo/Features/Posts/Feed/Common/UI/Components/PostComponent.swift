//
//  PostComponent.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import Bento
import BentoKit

final class PostComponent: Renderable {
    
    private let title: String
    private let body: String
    private var didTap: (() -> Void)? = nil
    
    // Used to "sneak peek" the post's content
    private let visibleBodyLength = 20

    typealias View = PostCell
    
    init(title: String, body: String, didTap: (() -> Void)? = nil) {
        self.title = title
        self.body = body
        self.didTap = didTap
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(in view: PostCell) {
        
        let sneakPeek = String.Index.init(encodedOffset: visibleBodyLength < body.count ? visibleBodyLength : body.count / 2)
        
        view.titleLabel.text = title
        view.descriptionLabel.text = "\(String(body[..<sneakPeek]))..."
        view.didTap = didTap
    }
}
