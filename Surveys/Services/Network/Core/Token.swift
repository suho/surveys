//
//  Token.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

struct Token {
    static var current: Token? {
        set {
            let encoder = JSONEncoder()
            guard let value = newValue, let encoded = try? encoder.encode(value) else { return }
            UserDefaults.standard.set(encoded, forKey: DefaultsKeys.current.rawValue)
        }
        get {
            let decoder = JSONDecoder()
            guard let data = UserDefaults.standard.object(forKey: DefaultsKeys.current.rawValue) as? Data,
                let current = try? decoder.decode(Token.self, from: data) else { return nil }
            return current
        }
    }

    var token: String = ""
    var type: String = ""
    var expires: Int = 0
    var createdAt: Int = 0

    var expired: Bool {
        let expiredDate: Date = Date(timeIntervalSince1970: TimeInterval(createdAt + expires))
        return expiredDate.isInPast
    }

    func isValid() -> Bool {
        return token.isNotEmpty && !expired
    }
}

// MARK: - Codable
extension Token: Codable {
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
        case expires = "expires_in"
        case createdAt = "created_at"
    }
}

// MARK: - Define
extension Token {
    private enum DefaultsKeys: String {
        case current
    }
}
