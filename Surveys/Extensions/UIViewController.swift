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

    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.okay, style: .default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

private extension Constants {
    static let surveys = "Surveys"
    static let okay = "OK"
}
