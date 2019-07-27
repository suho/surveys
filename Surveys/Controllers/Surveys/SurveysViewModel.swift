//
//  SurveysViewModel.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation
import Moya

protocol SurveysViewModelDelegate: class {
    func viewModel(_ viewModel: SurveysViewModel, performAction action: SurveysViewModel.Action)
}

final class SurveysViewModel {
    private var surveys: [Survey] = []
    private let useCase: SurveyUseCase
    private var page: Int = 1
    private var isLoading: Bool = false
    private var shouldNotLoadMore = false
    weak var delegate: SurveysViewModelDelegate?

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
    func fetch(completion: (() -> Void)? = nil) {
        if isLoading { return }
        isLoading = true
        delegate?.viewModel(self, performAction: .showLoading(isLoading))
        useCase.list(page: 1, perPage: Configuration.dataPerPage) { [weak self](result) in
            guard let this = self else { return }
            this.isLoading = false
            this.delegate?.viewModel(this, performAction: .showLoading(this.isLoading))
            switch result {
            case .success(let data):
                this.surveys = data
                this.page = 1
                this.shouldNotLoadMore = false
                this.delegate?.viewModel(this, performAction: .didFetch)
            case .failure(let error):
                this.delegate?.viewModel(this, performAction: .didFail(error))
            }
            completion?()
        }
    }

    func loadMore(completion: (() -> Void)? = nil) {
        if isLoading { return }
        isLoading = true
        useCase.list(page: page + 1, perPage: Configuration.dataPerPage) { [weak self](result) in
            guard let this = self else { return }
            this.isLoading = false
            switch result {
            case .success(let data):
                if data.isNotEmpty {
                    this.surveys.append(contentsOf: data)
                    this.page += 1
                } else {
                    this.shouldNotLoadMore = true
                }
                this.delegate?.viewModel(this, performAction: .didLoadMore)
            case .failure(let error):
                this.delegate?.viewModel(this, performAction: .didFail(error))
            }
            completion?()
        }
    }
}

// MARK: - Configuration
extension SurveysViewModel {
    private enum Configuration {
        static let dataPerPage: Int = 10
    }

    enum Action {
        case didFetch
        case didLoadMore
        case didFail(Error)
        case showLoading(Bool)
    }
}
