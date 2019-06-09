//
//  MockNetwork.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

@testable import Surveys

final class MockNetwork: SurveyUseCase {

    var shouldSuccess: Bool = false

    func list(page: Int, perPage: Int, completion: @escaping (Result<[Survey], Error>) -> Void) {
        if shouldSuccess {
            completion(.success(Survey.list))
        } else {
            completion(.failure(MockNetwork.Error.fail))
        }
    }
}

// MARK: - MockNetwork
extension MockNetwork {
    enum Error: Swift.Error {
        case fail
    }
}

// MARK: - Dummy
extension Survey {
    static let dummy: Survey = {
        return Survey(id: "id", title: "title", description: "description", coverImageURL: "coverImageURL")
    }()
    static let list: [Survey] = {
        return [Survey](repeating: Survey.dummy, count: 5)
    }()
}
