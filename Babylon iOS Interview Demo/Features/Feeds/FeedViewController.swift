//
//  FeedViewController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let viewModel: FeedViewModel
    
    init(with viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "Feed"
        self.view.backgroundColor = .red
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [viewModel] in
            viewModel.send(action: .didSelect(post: Post(id: 1, userId: 1, title: "hey", body: "lol")))
        }
    }
}
