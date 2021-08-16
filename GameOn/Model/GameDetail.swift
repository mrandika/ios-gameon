//
//  GameDetail.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import Foundation
import SwiftUI

struct GameDetail: Codable {
    var gameId: Int
    var name, descriptionRaw: String?
    var playtime: Int? = 0
    var released: Date?
    var backgroundImage: String?
    var rating: Double? = 0.0
    var metacritic: Int? = 0
    var ratingTop: Int? = 5
    var ratingsCount: Int? = 0
    var ratings: [Rating]?

    var suggestionsCount: Int? = 0
    var reviewsCount: Int? = 0
    var genres: [Genre]?
    var developers: [Developer]?
    var publishers: [Publisher]?
    var esrbRating: EsrbRating?

    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case name, rating, playtime, released, metacritic
        case ratingTop = "rating_top"
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
        case suggestionsCount = "suggestions_count"
        case ratingsCount = "ratings_count"
        case reviewsCount = "reviews_count"
        case ratings, genres, developers, publishers
        case esrbRating = "esrb_rating"
    }

    var metacriticColor: Color {
        if let metacriticScore = metacritic {
            if metacriticScore >= 75 && metacriticScore <= 100 {
                return Color.systemGreen
            } else if metacriticScore >= 50 {
                return Color.systemYellow
            } else if metacriticScore >= 20 {
                return Color.systemRed
            } else {
                return Color.systemGray
            }
        } else {
            return Color.systemGray
        }
    }

    var backgroundUrl: URL {
        return URL(string: backgroundImage ?? "https://media.rawg.io/media/screenshots/")!
    }

    var genreText: String? {
        guard let gameGenres = self.genres else {
            return ""
        }

        return gameGenres.prefix(3).map { $0.name }.joined(separator: ", ")
    }
}

extension GameDetail {
    static var fake: GameDetail {
        GameDetail(gameId: 1, name: "Game",
                   descriptionRaw: "Lorem dorem ipsum dolor sit amet. Lorem dorem ipsum dolor sit amet.",
                   ratingsCount: 10, developers: Developer.fakes, publishers: Publisher.fakes)
    }
}

// MARK: - Developer
struct Developer: Codable {
    var developerId: Int
    var name, slug: String
    var gamesCount: Int

    enum CodingKeys: String, CodingKey {
        case developerId = "id"
        case name, slug
        case gamesCount = "games_count"
    }
}

extension Developer {
    static var fakes: [Developer] {
        return [
            Developer.fake,
            Developer.fake,
            Developer.fake
        ]
    }

    static var fake: Developer {
        Developer(developerId: 1, name: "Rockstar", slug: "rockstar", gamesCount: 100)
    }
}

// MARK: - Publisher
struct Publisher: Codable {
    var publisherId: Int
    var name, slug: String
    var gamesCount: Int

    enum CodingKeys: String, CodingKey {
        case publisherId = "id"
        case name, slug
        case gamesCount = "games_count"
    }
}

extension Publisher {
    static var fakes: [Publisher] {
        return [
            Publisher.fake,
            Publisher.fake,
            Publisher.fake
        ]
    }

    static var fake: Publisher {
        Publisher(publisherId: 1, name: "Rockstart", slug: "rockstart", gamesCount: 100)
    }
}
