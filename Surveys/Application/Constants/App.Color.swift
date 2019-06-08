//
//  App.Color.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit
import SwifterSwift

extension App {
    enum Color {}
}

// MARK: - App.Color
extension App.Color {
    static let surveyButton: UIColor = UIColor(hex: 0xCA202E) ?? .clear
    static let surveyTitle: UIColor = .white
    static let barBackground: UIColor = UIColor(red: 20, green: 32, blue: 56) ?? .clear
    static let barTint: UIColor = .white
}
