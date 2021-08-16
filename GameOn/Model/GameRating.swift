//
//  GameRating.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import Foundation
import SwiftUI

// MARK: - Rating Struct
struct Rating: Codable {
    var ratingId: Int
    var title: String
    var count: Int
    var percent: Double

    enum CodingKeys: String, CodingKey {
        case ratingId = "id"
        case title, count, percent
    }

    var titleColor: Color {
        if title == "exceptional" {
            return .systemIndigo
        } else if title == "recommended" {
            return .systemGreen
        } else if title == "meh" {
            return .systemOrange
        } else if title == "skip" {
            return .systemRed
        } else {
            return .black
        }
    }
}

// MARK: - Games Fakes Extension
extension Rating {
    static var fakes: [Rating] {
        return [
            Rating.fakeExceptional,
            Rating.fakeRecommended,
            Rating.fakeMeh,
            Rating.fakeSkip
        ]
    }

    static var fakeExceptional: Rating {
        Rating(ratingId: 5, title: "exceptional", count: 2939, percent: 59.13)
    }

    static var fakeRecommended: Rating {
        Rating(ratingId: 4, title: "recommended", count: 1634, percent: 32.88)
    }

    static var fakeMeh: Rating {
        Rating(ratingId: 3, title: "meh", count: 314, percent: 6.32)
    }

    static var fakeSkip: Rating {
        Rating(ratingId: 1, title: "skip", count: 83, percent: 1.67)
    }
}
