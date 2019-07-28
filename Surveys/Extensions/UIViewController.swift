//
//  UIViewController.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        showAlert(title: Constants.surveys, message: error.localizedDescription)
    }
}

private extension Constants {
    static let surveys = "Surveys"
}
