//
//  Constants.Error.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

extension Constants {
    enum Error {
        case indexOutOfRange
        case notFound
    }
}

// MARK: - Error
extension Constants.Error: Swift.Error {}
