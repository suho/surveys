//
//  Data.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

extension Data {
    init(forResource name: String, withExtension ext: String, bundle: Bundle = Bundle.main) throws {
        guard let url = bundle.url(forResource: name, withExtension: ext) else { throw Constants.Error.notFound }
        try self.init(contentsOf: url)
    }
}
