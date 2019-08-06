//
//  String.swift
//  Surveys
//
//  Created by Su Ho V. on 7/28/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
