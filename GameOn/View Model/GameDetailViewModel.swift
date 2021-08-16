//
//  GameDetailViewModel.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import Foundation

class GameDetailViewModel: ObservableObject {
    // MARK: - UI
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error?

    // MARK: - Data
    @Published var game: GameDetail = GameDetail(gameId: 0)

    let gameDetailService = GameDetailService()

    func fetchDetail(gameId: Int) {
        self.isLoading = true
        self.isError = false

        gameDetailService.detail(gameId: gameId) { status in
            switch status {
            case .success(let result):
                DispatchQueue.main.async {
                    self.game = result
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
