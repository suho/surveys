//
//  SurveysViewModelTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Surveys

final class SurveysViewModelTests: QuickSpec {
    override func spec() {
        super.spec()
        let network = MockNetwork()
        var viewModel = SurveysViewModel(useCase: network)
        describe("Surveys ViewModel Testing") {
            context("Init") {
                beforeEach {
                    viewModel = SurveysViewModel(useCase: network)
                }
                it("Data After Init Testing") {
                    expect(viewModel.numberOfItems(in: 0)) == 0
                    expect {
                        try viewModel.viewModelForItem(at: 0)
                    }.to(throwError(App.Error.indexOutOfRange))
                }
            }

            context("Fetch API Success", closure: {
                beforeEach {
                    network.shouldSuccess = true
                    viewModel = SurveysViewModel(useCase: network)
                }

                it("Data After Fetch API Success Testing", closure: {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        viewModel.fetch(shouldLoadMore: false, completion: { _ in
                            expect(viewModel.numberOfItems(in: 0)) == 10
                            expect {
                                try viewModel.viewModelForItem(at: 0)
                            }.notTo(throwError(App.Error.indexOutOfRange))
                            expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                            expect(viewModel.shouldLoadMore(at: Configuration.sixthIndexPath)) == true
                            done()
                        })
                    })
                })

                it("Data After Fetch API Loadmore Success Testing", closure: {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        viewModel.fetch(shouldLoadMore: true, completion: { _ in
                            expect(viewModel.numberOfItems(in: 0)) == 10
                            expect {
                                try viewModel.viewModelForItem(at: 0)
                                }.notTo(throwError(App.Error.indexOutOfRange))
                            expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                            expect(viewModel.shouldLoadMore(at: Configuration.sixthIndexPath)) == true
                            done()
                        })
                    })
                })
            })

            context("Fetch API Success But Data Empty", closure: {
                beforeEach {
                    network.emptyData = true
                    network.shouldSuccess = true
                    viewModel = SurveysViewModel(useCase: network)
                }

                it("Data After Fetch API Success But Empty Data Testing", closure: {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        viewModel.fetch(shouldLoadMore: true, completion: { _ in
                            expect(viewModel.numberOfItems(in: 0)) == 0
                            expect {
                                try viewModel.viewModelForItem(at: 0)
                                }.to(throwError(App.Error.indexOutOfRange))
                            expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                            done()
                        })
                    })
                })
            })

            context("Fetch API Failure", closure: {
                beforeEach {
                    network.shouldSuccess = false
                    viewModel = SurveysViewModel(useCase: network)
                }

                it("Data After Fetch API Failure Testing", closure: {
                    waitUntil(timeout: Configuration.timeout, action: { done in
                        viewModel.fetch(shouldLoadMore: true, completion: { _ in
                            expect(viewModel.numberOfItems(in: 0)) == 0
                            expect {
                                try viewModel.viewModelForItem(at: 0)
                                }.to(throwError(App.Error.indexOutOfRange))
                            expect(viewModel.shouldLoadMore(at: Configuration.firstIndexPath)) == false
                            done()
                        })
                    })
                })
            })
        }
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
