//
//  NimbleNetwork.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Moya

final class NimbleNetwork: SurveyUseCase {
    private let provider: MoyaProvider<NimbleTarget>

    init(provider: MoyaProvider<NimbleTarget>) {
        self.provider = provider
    }

    func list(page: Int, perPage: Int, completion: @escaping (Result<[Survey], Error>) -> Void) {
        provider.request(.surveys(page: page, perPage: perPage)) { result in
            switch result {
            case .success(let value):
                guard let surveys: [Survey] = try? JSONDecoder().decode([Survey].self, from: value.data) else {
                    completion(.failure(NetworkError.requestMapping))
                    return
                }
                completion(.success(surveys))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
