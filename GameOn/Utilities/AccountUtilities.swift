//
//  AccountUtilities.swift
//  GameOn
//
//  Created by Andika on 12/08/21.
//

import Foundation

class AccountUtilities {
    func generateGameCode(name: String, steamName: String, egsName: String, gamerLevel: String,
                          isFavoriteShareable: Bool, favorite: [Int]? = []) -> String {
        var profile: Profile

        if isFavoriteShareable {
            profile = Profile(name: name,
                                  steamName: steamName, egsName: egsName,
                                  gamerLevel: gamerLevel, favoritedGameId: favorite)
        } else {
            profile = Profile(name: name,
                                  steamName: steamName, egsName: egsName,
                                  gamerLevel: gamerLevel)
        }

        do {
            let json = try JSONEncoder().encode(profile)
            let gameCode = String(data: json, encoding: .utf8)!

            return gameCode
        } catch {
            return error.localizedDescription
        }
    }

    func decodeGameData(data: Data, completion: @escaping (Result<Profile, DataError>) -> Void) {
        do {
            let profile = try JSONDecoder().decode(Profile.self, from: data) as Profile

            completion(.success(profile))
        } catch {
            completion(.failure(.decodingFail(code: -5,
                                              message: "Failure when attempting to decode the data.")))
        }
    }
}
