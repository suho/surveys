//
//  Application.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD

final class Application {
    static let current = Application()
    var window: UIWindow?

    private init() {}

    func root(in window: UIWindow?) {
        self.window = window
        let provider = MoyaProvider<NimbleTarget>(requestClosure: MoyaProvider<NimbleTarget>.tokenRequestMapping)
        let useCase = NimbleNetwork(provider: provider)
        let controller = SurveysViewController()
        let viewModel = SurveysViewModel(useCase: useCase)
        controller.viewModel = viewModel
        let navigation = NavigationController(rootViewController: controller)
        window?.rootViewController = navigation
    }

    func configure() {
        SVProgressHUD.setDefaultMaskType(.clear)
    }
}
