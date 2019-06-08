//
//  SurveyUseCase.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

protocol SurveyUseCase {
    func list(page: Int, perPage: Int, completion: @escaping (Result<[Survey], Error>) -> Void)
}
