//
//  GameService.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import Foundation

class GameService {
    var page = 1

    private func fetch(url: URL, completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 10

        let urlSession = URLSession(configuration: config)

        let task = urlSession.dataTask(with: url) { data, response, _ in
            guard let response = response as? HTTPURLResponse else { return }

            let statusCode = response.statusCode

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            if let data = data {
                if statusCode == 200 {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(formatter)

                    do {
                        let games = try decoder.decode(GamesResponse.self, from: data)

                        completion(.success(games))
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

    func newRelease(completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        fetch(url: GameRepo().getNewlyReleased(page: page)) { status in
            switch status {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func topRated(completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        fetch(url: GameRepo().getTopRated(page: page)) { status in
            switch status {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func platform(platform: Int, completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        fetch(url: GameRepo().getPlatformBased(platform: platform)) { status in
            switch status {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func discover(completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        fetch(url: GameRepo().getDiscovery(page: page)) { status in
            switch status {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func search(query: String, completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        fetch(url: GameRepo().getSearchQuery(query: query, page: page)) { status in
            switch status {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
