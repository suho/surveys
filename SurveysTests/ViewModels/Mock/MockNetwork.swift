//
//  MockNetwork.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

@testable import Surveys

final class MockNetwork {
    var shouldSuccess: Bool = false
    var emptyData: Bool = false
}

// MARK: - SurveyUseCase
extension MockNetwork: SurveyUseCase {
    func list(page: Int, perPage: Int, completion: @escaping (Result<[Survey], Swift.Error>) -> Void) {
        if shouldSuccess {
            if emptyData {
                completion(.success([]))
            } else {
                completion(.success(Survey.list))
            }

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
        return [Survey](repeating: Survey.dummy, count: 10)
    }()
}
