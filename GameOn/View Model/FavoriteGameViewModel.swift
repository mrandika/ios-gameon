//
//  FavoriteGameViewModel.swift
//  GameOn
//
//  Created by Andika on 12/08/21.
//

import Foundation
import CoreData

class FavoriteGameViewModel: NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
    @Published var games: [FavoriteGame] = []
    @Published var gameExist: Bool = false

    static let shared = FavoriteGameViewModel(favoritesGameService: FavoriteGameService(
                                                persistenceController: PersistenceController.shared))

    private let favoritesGameService: FavoriteGameService
    private let fetchedResultsController: NSFetchedResultsController<FavoriteGame>

    init(favoritesGameService: FavoriteGameService) {
        self.favoritesGameService = favoritesGameService
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: favoritesGameService.gamesFetchRequest,
                                                                   managedObjectContext: favoritesGameService.context,
                                                                   sectionNameKeyPath: nil, cacheName: nil)
    }

    func checkGame(gameId: Int) {
        self.gameExist = false

        let context = favoritesGameService.context

        do {
            self.gameExist = try context.fetch(favoritesGameService.checkGameLocally(gameId: gameId)).first != nil
        } catch {
            debugPrint(error)
        }
    }

    func fetch() {
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()

        self.games = fetchedResultsController.fetchedObjects ?? []
    }

    func save(game: GameDetail) {
        let favorite = FavoriteGame(context: favoritesGameService.context)

        favorite.gameId = Int32(game.gameId)
        favorite.name = game.name
        favorite.backgroundImage = game.backgroundImage
        favorite.playtime = Int32(game.playtime ?? 0)
        favorite.released = game.released
        favorite.rating = game.rating ?? 0
        favorite.addedDate = Date()

        PersistenceController.shared.save()

        self.gameExist.toggle()
        self.fetch()
    }

    func delete(gameId: Int) {
        let context = favoritesGameService.context

        do {
            try context.delete(context.fetch(favoritesGameService.checkGameLocally(gameId: gameId)).first!)

            self.gameExist.toggle()
            self.fetch()
        } catch {
            debugPrint(error)
        }
    }
}
