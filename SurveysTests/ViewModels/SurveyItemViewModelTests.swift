//
//  SurveyItemViewModelTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
@testable import Surveys

final class SurveyItemViewModelTests: QuickSpec {
    override func spec() {
        super.spec()
        let survey: Survey = Survey.dummy
        var viewModel = SurveyItemViewModel(survey: survey)
        describe("A survey item view model") {
            context("when initializing with survey") {
                beforeEach {
                    viewModel = SurveyItemViewModel(survey: survey)
                }
                it("has value for each properties as expected") {
                    expect(viewModel.title) == "title"
                    expect(viewModel.description) == "description"
                    expect(viewModel.imagePath) == "coverImageURL" + "l"
                }
            }
        }
    }
}
