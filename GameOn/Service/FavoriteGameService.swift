//
//  FavoriteGameService.swift
//  GameOn
//
//  Created by Andika on 12/08/21.
//

import Foundation
import CoreData

class FavoriteGameService {
    private let persistenceController: PersistenceController

    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    var gamesFetchRequest: NSFetchRequest<FavoriteGame> {
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addedDate", ascending: false)]
        fetchRequest.returnsObjectsAsFaults = false

        return fetchRequest
    }

    func checkGameLocally(gameId: Int) -> NSFetchRequest<FavoriteGame> {
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(
            format: "gameId == %d", gameId
        )

        return fetchRequest
    }

    var context: NSManagedObjectContext {
        persistenceController.container.viewContext
    }
}
