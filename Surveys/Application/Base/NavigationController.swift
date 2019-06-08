//
//  NavigationController.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }

    private func setupAppearance() {
        navigationBar.barTintColor = App.Color.barBackground
        navigationBar.tintColor = App.Color.barTint
        navigationBar.titleTextAttributes = [.foregroundColor: App.Color.barTint]
    }
}
