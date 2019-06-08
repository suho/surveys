//
//  Survey.swift
//  Surveys
//
//  Created by Su Ho V. on 6/8/19.
//  Copyright © 2019 suho. All rights reserved.
//

import Foundation

final class Survey {
    let id: String
    let title: String
    let description: String
    let coverImageURL: String

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        coverImageURL = try container.decodeIfPresent(String.self, forKey: .coverImageURL) ?? ""
    }
}

// MARK: - Codable
extension Survey: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case coverImageURL = "cover_image_url"
    }
}
