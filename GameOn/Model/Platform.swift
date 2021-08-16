//
//  Platform.swift
//  GameOn
//
//  Created by Andika on 13/08/21.
//

import Foundation

struct PlatformResponse: Codable {
    var platforms: [Platform]

    enum CodingKeys: String, CodingKey {
        case platforms = "results"
    }
}

// MARK: - Games Struct
struct Platform: Codable {
    var platformId: Int
    var name: String = ""
    var slug: String? = ""

    enum CodingKeys: String, CodingKey {
        case platformId = "id"
        case name, slug
    }
}
