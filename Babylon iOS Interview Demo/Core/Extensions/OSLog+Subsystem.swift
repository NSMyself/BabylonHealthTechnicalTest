//
//  OSLog+Subsystem.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 26/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import os.log
import Foundation

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let parser = OSLog(subsystem: subsystem, category: "Parser")
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let storage = OSLog(subsystem: subsystem, category: "Storage")
}
