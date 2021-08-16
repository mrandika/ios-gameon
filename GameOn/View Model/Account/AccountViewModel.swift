//
//  AccountViewModel.swift
//  GameOn
//
//  Created by Andika on 11/08/21.
//

import Foundation

class AccountViewModel: ObservableObject {
    // MARK: - UI
    @Published var showAlert: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error?

    // MARK: - Data
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "user.name")
        }
    }

    @Published var steamName: String {
        didSet {
            UserDefaults.standard.set(steamName, forKey: "user.steamName")
        }
    }

    @Published var egsName: String {
        didSet {
            UserDefaults.standard.set(egsName, forKey: "user.egsName")
        }
    }

    @Published var gamerLevel: String {
        didSet {
            UserDefaults.standard.set(gamerLevel, forKey: "user.gamerLevel")
        }
    }

    @Published var gameCodeSharing: Bool {
        didSet {
            UserDefaults.standard.set(gameCodeSharing, forKey: "user.gameCodeSharing")
        }
    }

    @Published var shareFavorites: Bool {
        didSet {
            UserDefaults.standard.set(shareFavorites, forKey: "user.shareFavorites")
        }
    }

    init() {
        self.name = UserDefaults.standard.object(forKey: "user.name") as? String ?? ""
        self.steamName = UserDefaults.standard.object(forKey: "user.steamName") as? String ?? ""
        self.egsName = UserDefaults.standard.object(forKey: "user.egsName") as? String ?? ""
        self.gamerLevel = UserDefaults.standard.object(forKey: "user.gamerLevel") as? String ?? "NEW_GAMER"
        self.gameCodeSharing = UserDefaults.standard.object(forKey: "user.gameCodeSharing") as? Bool ?? true
        self.shareFavorites = UserDefaults.standard.object(forKey: "user.shareFavorites") as? Bool ?? false
    }

    let utilities = AccountUtilities()
    public var gamerLevels = ["NEW_GAMER", "QUITE_LONG_GAMER", "LONG_GAMER", "OG_GAMER"]

    func isProfileComplete() -> Bool {
        return (name != "" || !name.isEmpty) && (gamerLevel != "" || gamerLevel.isEmpty)
    }

    func gameCodeData() -> String {
        var data: String

        if shareFavorites {
            FavoriteGameViewModel.shared.fetch()

            var gameId: [Int] = []
            let games = FavoriteGameViewModel.shared.games.prefix(3)

            for game in games {
                gameId.append(Int(game.gameId))
            }

            data = utilities.generateGameCode(name: self.name,
                                              steamName: self.steamName,
                                              egsName: self.egsName,
                                              gamerLevel: self.gamerLevel,
                                              isFavoriteShareable: self.shareFavorites, favorite: gameId)
        } else {
            data = utilities.generateGameCode(name: self.name,
                                          steamName: self.steamName,
                                          egsName: self.egsName,
                                          gamerLevel: self.gamerLevel, isFavoriteShareable: self.shareFavorites)
        }

        return data
    }

    func decodeGameData(data: Data) -> Profile {
        do {
            let profile = try JSONDecoder().decode(Profile.self, from: data) as Profile

            if profile.name.isEmpty {
                self.showAlert = true
                self.isError = true
            }

            return profile
        } catch {
            self.showAlert = true
            self.isError = true
            self.error = error
        }

        return Profile(name: "", steamName: "", egsName: "", gamerLevel: "")
    }
}
