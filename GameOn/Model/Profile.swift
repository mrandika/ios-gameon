//
//  Profile.swift
//  GameOn
//
//  Created by Andika on 14/08/21.
//

import Foundation

struct Profile: Codable {
    var name: String
    var steamName: String
    var egsName: String
    var gamerLevel: String
    var favoritedGameId: [Int]?
}

extension Profile {
    static var fake: Profile {
        return Profile(name: "John Doe", steamName: "johndoe1024", egsName: "johndoe2048",
                       gamerLevel: "OG_GAMER", favoritedGameId: [
                        3498, 3328, 4200
                       ]
        )
    }
}
