//
//  SurveyTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 7/28/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
@testable import Surveys

class SurveyTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("A survey") {
            var survey: Survey!
            context("when initializing with dummy data", closure: {
                beforeEach {
                    survey = Survey.dummy
                }
                it("has value for each properties as expected") {
                    expect(survey.id) == "id"
                    expect(survey.title) == "title"
                    expect(survey.description) == "description"
                    expect(survey.coverImageURL) == "coverImageURL"
                }
            })
        }
    }
}
