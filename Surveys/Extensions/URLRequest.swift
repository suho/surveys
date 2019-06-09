//
//  URLRequest.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

extension URLRequest {
    mutating func update(token: Token) {
        let type = TokenType(value: token.type)
        switch type {
        case .bearer:
            let authValue = type.value + " " + token.token
            addValue(authValue, forHTTPHeaderField: "Authorization")
        }
    }
}
