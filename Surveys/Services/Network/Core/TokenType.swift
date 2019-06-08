//
//  TokenAuthorizable.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

enum TokenType: String {
    case none
    case bearer

    var value: String {
        switch self {
        case .none: return "none"
        case .bearer: return "Bearer"
        }
    }
}

// MARK: - Initiual
extension TokenType {
    init(value: String) {
        guard let type = TokenType(rawValue: value) else {
            self = .none
            return
        }
        self = type
    }
}
