//
//  String+localized.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 27/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "\(self) comment")
    }
}
