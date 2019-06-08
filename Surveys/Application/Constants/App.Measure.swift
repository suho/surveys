//
//  App.Measure.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

extension App {
    enum Measure {}
}

// MARK: - App.Measure
extension App.Measure {
    static let screenSize: CGSize = UIScreen.main.bounds.size
    static let navigationBarHeight = UINavigationBar.appearance().height
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
}
