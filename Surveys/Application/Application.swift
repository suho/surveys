//
//  Application.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class Application {
    static let current = Application()
    var window: UIWindow?

    private init() {}

    func root(in window: UIWindow?) {
        self.window = window
        let controller = SurveysViewController()
        let navigation = NavigationController(rootViewController: controller)
        window?.rootViewController = navigation
    }
}
