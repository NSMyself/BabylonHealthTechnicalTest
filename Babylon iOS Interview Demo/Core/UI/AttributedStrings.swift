//
//  AttributedStrings.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func generate(title: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title)
        
        let attributes0: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "HelveticaNeue-Bold", size: 13)!
        ]
        attributedString.addAttributes(attributes0, range: NSRange(location: 0, length: 10))
        
        return attributedString
    }
}
