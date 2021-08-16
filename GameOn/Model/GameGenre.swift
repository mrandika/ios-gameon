//
//  GameGenre.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import Foundation

struct Genre: Codable {
    var genreId: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name
    }
}

extension Genre {
    static var fakes: [Genre] {
        return [
            Genre.fake,
            Genre.fake,
            Genre.fake,
            Genre.fake
        ]
    }

    static var fake: Genre {
        Genre(genreId: 1, name: "Action")
    }
}
