//
//  SurveyItemViewModel.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

struct SurveyItemViewModel {
    private let survey: Survey
    var title: String {
        return survey.title.trimmed
    }
    var description: String {
        return survey.description.trimmed
    }
    var imagePath: String {
        return survey.coverImageURL + "l"
    }

    init(survey: Survey) {
        self.survey = survey
    }
}
