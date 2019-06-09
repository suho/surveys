//
//  SurveysController.swift
//  SurveysController
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
import Moya
@testable import Surveys

final class SurveysControllerTests: QuickSpec {
    override func spec() {
        super.spec()
        let provider = MoyaProvider<NimbleTarget>(endpointClosure: NetworkTests.successEndpointClosure,
                                                  stubClosure: MoyaProvider.immediatelyStub)
        let useCase = NimbleNetwork(provider: provider)
        let controller = SurveysViewController()
        let viewModel = SurveysViewModel(useCase: useCase)
        controller.viewModel = viewModel
        describe("Load View") {
            context("Init Data After Load View") {
                beforeEach {
                    controller.loadViewIfNeeded()
                }
                it("Data After Init Testing") {
                    expect(controller.collectionView.numberOfItems()) == 8
                }
            }
        }
    }
}

// MARK: - Configuration
extension SurveysControllerTests {
    enum Configuration {
        static let timeout: TimeInterval = 15
    }
}
