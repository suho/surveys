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
                    expect(try viewModel.viewModelForItem(at: 0)).to(throwError(App.Error.indexOutOfRange))
                }
            }
        }
    }
}
