//
//  CollectionTests.swift
//  SurveysTests
//
//  Created by Su Ho V. on 7/28/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Quick
import Nimble
@testable import Surveys

final class CollectionTests: QuickSpec {
    override func spec() {
        super.spec()
        describe("A array") {
            var array: [Int]!
            context("when initializing with empty data") {
                beforeEach {
                    array = []
                }
                it("has value isNotEmpty as expected") {
                    expect(array.isNotEmpty) == false
                }
            }

            context("when initializing with data") {
                beforeEach {
                    array = [1, 2, 3]
                }
                it("has value isNotEmpty as expected") {
                    expect(array.isNotEmpty) == true
                }
            }
        }
    }
}
