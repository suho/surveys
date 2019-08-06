//
//  Date.swift
//  Surveys
//
//  Created by Su Ho V. on 7/28/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

extension Date {
    var isInPast: Bool {
        return self < Date()
    }
}
