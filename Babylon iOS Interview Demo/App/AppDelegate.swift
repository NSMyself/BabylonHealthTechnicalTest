//
//  AppDelegate.swift
//  Babylon iOS Interview Demo
//
//  Created by João Pereira on 18/01/2019.
//  Copyright © 2019 NSMyself. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootFlowController = RootFlowController(using: window)
        rootFlowController.start()
        
        return true
    }
}

