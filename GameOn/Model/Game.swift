//
//  Game.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import Foundation
import SwiftUI

struct GamesResponse: Codable {
    var games: [Game]?

    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

// MARK: - Games Struct
struct Game: Codable {
    var gameId: Int
    var name: String? = ""
    var released: Date?
    var backgroundImage: String?
    var rating: Double? = 0.0
    var metacritic: Int? = 0
    var ratingsCount, playtime: Int?
    var shortScreenshots: [ShortScreenshot]?
    var genres: [Genre]?
    var esrbRating: EsrbRating?

    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case name, released
        case backgroundImage = "background_image"
        case rating, metacritic
        case ratingsCount = "ratings_count"
        case playtime
        case shortScreenshots = "short_screenshots"
        case genres
        case esrbRating = "esrb_rating"
    }

    var releaseFormattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"

        guard let released = released else {
            return ""
        }

        return formatter.string(from: released)
    }

    var ratingString: String {
        if let rating = rating {
            return String(format: "%.1f", round(rating))
        } else {
            return "0"
        }
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

    var playtimeString: String {
        return String(playtime ?? 0)
    }

    var genreText: String? {
        guard let gameGenres = self.genres else {
            return ""
        }

        return gameGenres.prefix(3).map { $0.name }.joined(separator: ", ")
    }
}

// MARK: - Games Fakes Extension
extension Game {
    static var fakes: [Game] {
        return [
            Game(gameId: 1, name: "Game", released: Date(),
                 backgroundImage: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg",
                 rating: 4.48, metacritic: 90, playtime: 70, genres: Genre.fakes,
                 esrbRating: EsrbRating.fakes),
            Game(gameId: 2, name: "Game 2", released: Date(),
                 backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                 rating: 4.2, metacritic: 74, playtime: 20, genres: Genre.fakes,
                 esrbRating: EsrbRating.fakes),
            Game(gameId: 3, name: "Game 3", released: Date(),
                 backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                 rating: 4.2, metacritic: 74, playtime: 20, genres: Genre.fakes,
                 esrbRating: EsrbRating.fakes),
            Game(gameId: 4, name: "Game 4", released: Date(),
                 backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                 rating: 4.2, metacritic: 74, ratingsCount: 4915, playtime: 20, genres: Genre.fakes,
                 esrbRating: EsrbRating.fakes)
        ]
    }

    static var fake: Game {
        return Game(gameId: 1, name: "Game 1", released: Date(),
                    backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                    rating: 4.2, metacritic: 74, ratingsCount: 4915, playtime: 20, genres: Genre.fakes,
                    esrbRating: EsrbRating.fakes)
    }
}

struct EsrbRating: Codable {
    var rateId: Int
    var name, slug: String

    enum CodingKeys: String, CodingKey {
        case rateId = "id"
        case name, slug
    }

    var ratingImage: String {
        return "esrb.\(slug)"
    }
}

extension EsrbRating {
    static var fakes: EsrbRating {
        return EsrbRating.fake
    }

    static var fake: EsrbRating {
        EsrbRating(rateId: 1, name: "Mature", slug: "mature")
    }
}

struct ShortScreenshot: Codable {
    var screenshotId: Int
    var image: String

    enum CodingKeys: String, CodingKey {
        case screenshotId = "id"
        case image
    }

    var screenshotUrl: URL {
        return URL(string: image)!
    }
}

extension ShortScreenshot {
    static var fakes: [ShortScreenshot] {
        return [
            ShortScreenshot.fake,
            ShortScreenshot.fake,
            ShortScreenshot.fake,
            ShortScreenshot.fake
        ]
    }

    static var fake: ShortScreenshot {
        ShortScreenshot(screenshotId: Int.random(in: 0..<50),
                        image: "https://media.rawg.io/media/screenshots/a7c/a7c43871a54bed6573a6a429451564ef.jpg")
    }
}
