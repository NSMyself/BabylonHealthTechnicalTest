//
//  ShowPostViewController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit
import ReactiveSwift

final class ReaderViewController: UIViewController {
    
    let viewModel: ReaderViewModel
    private let padding: CGFloat = 8
    private let widthRatio: CGFloat = 0.9
    
    let scrollView: UIScrollView = {
        $0.frame = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    let stackView: UIStackView = {
        $0.frame = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .gray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let userLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .gray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let commentsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .gray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    init(with viewModel: ReaderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "post_details".localized
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(userLabel)
        stackView.addArrangedSubview(commentsLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding*2),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: widthRatio)
        ])
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.body
        userLabel.reactive.text <~ viewModel.username.signal
        commentsLabel.reactive.text <~ viewModel.numberOfComments.signal
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard isMovingFromParent else { return }
        NotificationCenter.default.post(Notification(name: .closePost))
    }
}
