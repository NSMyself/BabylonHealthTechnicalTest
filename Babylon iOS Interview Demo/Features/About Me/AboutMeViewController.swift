//
//  AboutMeViewController.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 22/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class AboutMeViewController: UIViewController {
    
    let titleLabel: UILabel = {
        $0.text = "hi".localized
        $0.font = .boldSystemFont(ofSize: 32)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let descLabel: UILabel = {
        $0.text = "hope_you_liked_it".localized
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let byeLabel: UILabel = {
        $0.text = "cheers".localized
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14)
        return $0
    }(UILabel())
    
    let dependenciesLabel: UILabel = {
        $0.text = "cheers".localized
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    
    let authorLabel: UILabel = {
        $0.text = "João Pereira"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 14)
        return $0
    }(UILabel())
    
    private let gridUnit: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "about_tab_title".localized
        self.view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(byeLabel)
        view.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: gridUnit),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: gridUnit),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -gridUnit),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: gridUnit/2),
            descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            byeLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: gridUnit/2),
            byeLabel.leadingAnchor.constraint(equalTo: descLabel.leadingAnchor),
            byeLabel.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: byeLabel.bottomAnchor, constant: gridUnit),
            authorLabel.leadingAnchor.constraint(equalTo: byeLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: byeLabel.trailingAnchor),
        ])
    }
}
