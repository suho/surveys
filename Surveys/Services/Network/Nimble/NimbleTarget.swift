//
//  NimbleTarget.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation
import Moya

enum NimbleTarget {
    case credentials
    case surveys(page: Int, perPage: Int)
}

// MARK: - Define
extension NimbleTarget {
    enum Default {
        static let data: [String: String] = [ParamKey.grantType.rawValue: "password",
                                              ParamKey.username.rawValue: "carlos@nimbl3.com",
                                              ParamKey.password.rawValue: "antikera"]
    }

    private enum ParamKey: String {
        case grantType = "grant_type"
        case username
        case password
        case page
        case perPage = "per_page"
    }
}

// MARK: - TargetType
extension NimbleTarget: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://nimble-survey-api.herokuapp.com") else {
            fatalError("Please Check Your URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .credentials:
            return "/oauth/token"
        case .surveys:
            return "/surveys.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .credentials:
            return .post
        default:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .credentials:
            return .requestParameters(parameters: Default.data, encoding: URLEncoding.queryString)
        case .surveys(let page, let perPage):
            return .requestParameters(parameters: [ParamKey.page.rawValue: page,
                                                   ParamKey.perPage.rawValue: perPage],
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
