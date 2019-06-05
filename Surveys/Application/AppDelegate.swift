//
//  AppDelegate.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        Application.current.root(in: window)
        window?.makeKeyAndVisible()
        return true
    }
}
