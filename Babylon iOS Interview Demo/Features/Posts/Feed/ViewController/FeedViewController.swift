//
//  FeedViewController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit
import BentoKit

final class FeedViewController: UIViewController {
    
    private let viewModel: FeedViewModel
    
    private let tableView: BentoTableView = {
        $0.frame = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.estimatedSectionFooterHeight = 18
        $0.estimatedSectionHeaderHeight = 18
        $0.sectionHeaderHeight = UITableView.automaticDimension
        $0.sectionFooterHeight = UITableView.automaticDimension
        $0.allowsMultipleSelection = false
        return $0
    }(BentoTableView())
    
    private let placeholder: UIView = {
        $0.frame = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        return $0
    }(UIView())
    
    init(with viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = viewModel.title
        view.backgroundColor = .white
        setupUI()
        bind()
    }
    
    private func setupUI() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func bind() {
        viewModel
            .box
            .producer
            .startWithValues { [tableView] in
                tableView.render($0, animated: true)
            }
    }
}

