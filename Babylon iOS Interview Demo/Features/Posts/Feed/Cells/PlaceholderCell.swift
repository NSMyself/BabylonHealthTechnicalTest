//
//  PostCell.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 25/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

final class PlaceholderCell: UIView {
    
    private let labelPadding: CGFloat = 8
    var id: Int = -1
    var didTap: ((Int) -> Void)?
    
    let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .center
        return $0
    }(UIStackView())
    
    let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.text = "No data to show"
        return $0
    }(UILabel())
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlaceholders()
    }
    
    private func setupPlaceholders() {
        addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
    }
    
    private func setupTapGesture() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc private func tapped(gestureRecognizer: UITapGestureRecognizer) {
        didTap?(id)
    }
}
