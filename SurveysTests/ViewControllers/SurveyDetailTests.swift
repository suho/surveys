//
//  SurveyDetailTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
@testable import Surveys

final class SurveyDetailTests: QuickSpec {
    override func spec() {
        super.spec()
        let survey: Survey = Survey.dummy
        let viewModel = SurveyItemViewModel(survey: survey)
        let controller = SurveyDetailViewController()
        controller.viewModel = viewModel
        describe("Load View") {
            context("Init Data After Load View") {
                beforeEach {
                    controller.loadViewIfNeeded()
                }
                it("Data After Init Testing") {
                    expect(controller.titleLabel.text) == "title"
                    expect(controller.descriptionLabel.text) == "description"
                }
            }
        }
    }
}
