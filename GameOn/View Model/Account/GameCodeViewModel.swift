//
//  GameCodeViewModel.swift
//  GameOn
//
//  Created by Andika on 14/08/21.
//

import SwiftUI

class GameCodeViewModel: ObservableObject {
    // MARK: - UI
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error?

    // MARK: - Data
    @Published var games: [GameDetail] = []

    let gameDetailService = GameDetailService()

    func fetchGame(gameId: [Int]) {
        self.isLoading = true
        self.isError = false

        for game in gameId {
            gameDetailService.detail(gameId: game) { status in
                switch status {
                case .success(let result):
                    DispatchQueue.main.async {
                        self.games.append(result)

                        if self.games.count == gameId.count {
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
