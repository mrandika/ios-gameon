//
//  DiscoveryGameViewModel.swift
//  GameOn
//
//  Created by Andika on 10/08/21.
//

import Foundation

class DiscoveryGameViewModel: ObservableObject {
    // MARK: - UI
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error?

    // MARK: - Data
    @Published var games: [Game] = []

    // MARK: - Constant
    let gameService = GameService()

    func fetchDiscovery() {
        self.isLoading = true
        self.isError = false

        gameService.discover { status in
            switch status {
            case .success(let result):
                DispatchQueue.main.async {
                    if let games = result.games {
                        self.games = games
                    }

                    self.isLoading = false
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
