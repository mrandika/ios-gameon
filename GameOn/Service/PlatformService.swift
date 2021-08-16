//
//  PlatformService.swift
//  GameOn
//
//  Created by Andika on 13/08/21.
//

import Foundation
import CoreData

class PlatformService {
    private let persistenceController: PersistenceController

    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    var context: NSManagedObjectContext {
        persistenceController.container.viewContext
    }

    private func fetch(url: URL, completion: @escaping (Result<PlatformResponse, Error>) -> Void) {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 10

        let urlSession = URLSession(configuration: config)

        let task = urlSession.dataTask(with: url) { data, response, _ in
            guard let response = response as? HTTPURLResponse else { return }

            let statusCode = response.statusCode

            if let data = data {
                if statusCode == 200 {
                    let decoder = JSONDecoder()

                    do {
                        let platforms = try decoder.decode(PlatformResponse.self, from: data)

                        completion(.success(platforms))
                    } catch {
                        completion(.failure(
                                    DataError.decodingFail(code: -5,
                                                           message: "Failure when attempting to decode the data.")
                        ))
                    }
                } else if statusCode >= 300 && statusCode < 400 {
                    completion(.failure(HttpError.redirection(code: statusCode, message: response.description)))
                } else if statusCode < 500 {
                    completion(.failure(HttpError.clientError(code: statusCode, message: response.description)))
                } else if statusCode > 500 && statusCode < 600 {
                    completion(.failure(HttpError.serverError(code: statusCode, message: response.description)))
                } else {
                    completion(.failure(HttpError.custom(code: statusCode, message: "Unknown status code.")))
                }
            } else {
                completion(.failure(DataError.custom(code: -1, message: "Unknown error, the data is nil.")))
            }
        }

        task.resume()
    }

    var platformsFetchRequest: NSFetchRequest<GamePlatform> {
        let fetchRequest: NSFetchRequest<GamePlatform> = GamePlatform.fetchRequest()
        fetchRequest.sortDescriptors = []
        fetchRequest.returnsObjectsAsFaults = false

        return fetchRequest
    }

    func platformLists(completion: @escaping (Result<PlatformResponse, Error>) -> Void) {
        fetch(url: PlatformRepo().getAllPlatform()) { status in
            switch status {
            case .success(let platforms):
                completion(.success(platforms))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func checkPlatformLocally(platformId: Int) -> NSFetchRequest<GamePlatform> {
        let fetchRequest: NSFetchRequest<GamePlatform> = GamePlatform.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(
            format: "platformId == %d", platformId
        )

        return fetchRequest
    }
}
