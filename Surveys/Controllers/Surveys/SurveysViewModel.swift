//
//  SurveysViewModel.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation
import Moya

final class SurveysViewModel {
    private var surveys: [Survey] = []
    private let useCase: SurveyUseCase
    private var page: Int = 1
    private var isLoading: Bool = false
    private var shouldNotLoadMore = false

    init(useCase: SurveyUseCase) {
        self.useCase = useCase
    }
}

// MARK: - DataSource
extension SurveysViewModel {
    func numberOfItems(in section: Int) -> Int {
        return surveys.count
    }

    func viewModelForItem(at index: Int) throws -> SurveyItemViewModel {
        guard surveys.indices.contains(index) else {
            throw App.Error.indexOutOfRange
        }
        return SurveyItemViewModel(survey: surveys[index])
    }

    func shouldLoadMore(at indexPath: IndexPath) -> Bool {
        return indexPath.item == surveys.count - 4 && !shouldNotLoadMore
    }
}

// MARK: - Fetch API
extension SurveysViewModel {
    func fetch(shouldLoadMore: Bool, completion: @escaping (Result<[Survey], Error>) -> Void) {
        if isLoading { return }
        isLoading = true
        useCase.list(page: shouldLoadMore ? page + 1 : 1, perPage: Configuration.dataPerPage) { [weak self](result) in
            guard let this = self else { return }
            this.isLoading = false
            switch result {
            case .success(let data):
                if shouldLoadMore {
                    if data.isNotEmpty {
                        this.surveys.append(contentsOf: data)
                        this.page += 1
                    } else {
                        this.shouldNotLoadMore = true
                    }
                } else {
                    this.surveys = data
                    this.page = 1
                    this.shouldNotLoadMore = false
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Configuration
extension SurveysViewModel {
    private enum Configuration {
        static let dataPerPage: Int = 10
    }
}
