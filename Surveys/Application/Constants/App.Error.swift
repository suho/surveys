//
//  App.Error.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

extension App {
    enum Error {
        case indexOutOfRange
    }
}

// MARK: - Error
extension App.Error: Error {}
