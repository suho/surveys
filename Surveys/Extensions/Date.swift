//
//  Date.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

private extension Date {
    var isPast: Bool {
        let now = Date()
        return compare(now) == ComparisonResult.orderedAscending
    }
}
