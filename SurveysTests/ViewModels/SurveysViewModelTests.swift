//
//  SurveysViewModelTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
@testable import Surveys

final class SurveysViewModelTests: QuickSpec {
    override func spec() {
        super.spec()
        let network = MockNetwork()
        let viewModel = SurveysViewModel(useCase: network)
        describe("A Surveys View Model") {
            initContext(network: network, viewModel: viewModel)
            fetchAPISuccessContext(network: network, viewModel: viewModel)
            dataEmptyContext(network: network, viewModel: viewModel)
            apiFailureContext(network: network, viewModel: viewModel)
        }
    }

    private func initContext(network: MockNetwork, viewModel: SurveysViewModel) {
        var viewModel = viewModel
        context("when initializing with MockNetwork") {
            beforeEach {
                viewModel = SurveysViewModel(useCase: network)
            }
            it("don't have any value in surveys list") {
                expect(viewModel.numberOfItems(in: 0)) == 0
                expect {
                    try viewModel.viewModelForItem(at: 0)
                    }.to(throwError(Constants.Error.indexOutOfRange))
            }
        }
    }

    private func dataEmptyContext(network: MockNetwork, viewModel: SurveysViewModel) {
        var viewModel = viewModel
        context("when the response success but empty data", closure: {
            beforeEach {
                network.emptyData = true
                network.shouldSuccess = true
                viewModel = SurveysViewModel(useCase: network)
            }

            it("don't have any value in surveys array", closure: {
                waitUntil(timeout: Configuration.timeout, action: { done in
                    viewModel.loadMore {
                        expect(viewModel.numberOfItems(in: 0)) == 0
                        expect { try viewModel.viewModelForItem(at: 0) }
                            .to(throwError(Constants.Error.indexOutOfRange))
                        done()
                    }
                })
            })

            it("can't not loadmore", closure: {
                waitUntil(timeout: Configuration.timeout, action: { done in
                    viewModel.loadMore {
                        expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                        done()
                    }
                })
            })
        })
    }

    private func apiFailureContext(network: MockNetwork, viewModel: SurveysViewModel) {
        var viewModel = viewModel
        context("when the response is failure", closure: {
            beforeEach {
                network.shouldSuccess = false
                viewModel = SurveysViewModel(useCase: network)
            }

            it("has empty surveys", closure: {
                waitUntil(timeout: Configuration.timeout, action: { done in
                    viewModel.loadMore {
                        expect(viewModel.numberOfItems(in: 0)) == 0
                        expect {
                            try viewModel.viewModelForItem(at: 0)
                            }.to(throwError(Constants.Error.indexOutOfRange))
                        done()
                    }
                })
            })

            it("can't not loadmore", closure: {
                waitUntil(timeout: Configuration.timeout, action: { done in
                    viewModel.loadMore {
                        expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                        done()
                    }
                })
            })
        })
    }

    private func fetchAPISuccessContext(network: MockNetwork, viewModel: SurveysViewModel) {
        var viewModel = viewModel
        context("when the response is success", closure: {
            beforeEach {
                network.shouldSuccess = true
                viewModel = SurveysViewModel(useCase: network)
            }

            it("has surveys data", closure: {
                waitUntil(timeout: Configuration.timeout, action: { done in
                    viewModel.fetch {
                        expect(viewModel.numberOfItems(in: 0)) == 10
                        expect {
                            try viewModel.viewModelForItem(at: 0)
                            }.notTo(throwError(Constants.Error.indexOutOfRange))
                        done()
                    }
                })
            })

            it("can loadmore", closure: {
                waitUntil(timeout: Configuration.timeout, action: { done in
                    viewModel.fetch {
                        expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                        expect(viewModel.shouldLoadMore(at: Configuration.sixthIndexPath)) == true
                        done()
                    }
                })
            })
        })
    }
}

// MARK: - Configuration
extension SurveysViewModelTests {
    enum Configuration {
        static let timeout: TimeInterval = 5
        static let firstIndexPath: IndexPath = IndexPath(item: 0, section: 0)
        static let sixthIndexPath: IndexPath = IndexPath(item: 6, section: 0)
    }
}
