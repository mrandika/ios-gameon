//
//  PlatformGameViewModel.swift
//  GameOn
//
//  Created by Andika on 10/08/21.
//

import Foundation

class PlatformGameViewModel: ObservableObject {
    // MARK: - UI
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error?

    // MARK: - Data
    @Published var games: [GamePlatform: [Game]] = [:]

    // MARK: - Constant
    let gameService = GameService()
    static let shared = PlatformGameViewModel()

    private func fetchPlatform(platform: Int, completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        gameService.platform(platform: platform) { status in
            switch status {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPlatform(platforms: [GamePlatform]) {
        self.isLoading = true
        self.isError = false

        if PlatformViewModel.shared.selectedPlatforms.count < 2 {
            PlatformViewModel.shared.provideDefaultPlatforms()
        }

        PlatformViewModel.shared.fetchSelectedPlatform()

        for platform in platforms {
            self.fetchPlatform(platform: Int(platform.platformId)) { status in
                switch status {
                case .success(let result):
                    DispatchQueue.main.async {
                        if let games = result.games {
                            self.games[platform] = games
                        }

                        if self.games.count == platforms.count {
                            self.isLoading = false
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.isError = true
                        self.error = error
                    }
                }
            }
        }
    }
}
