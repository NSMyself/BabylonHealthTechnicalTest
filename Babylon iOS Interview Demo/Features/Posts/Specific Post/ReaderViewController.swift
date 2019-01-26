//
//  ShowPostViewController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

class ReaderViewController: UIViewController {
    
    let post: Post
    private weak var delegate: ReaderDelegate?
    
    init(using post: Post, delegate: ReaderDelegate? = nil) {
        self.post = post
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .yellow
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard isMovingFromParent else { return }
        delegate?.dismissing()
    }
}
