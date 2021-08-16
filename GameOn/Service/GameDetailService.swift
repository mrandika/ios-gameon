//
//  GameDetailService.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import Foundation

class GameDetailService {
    func detail(gameId: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 10

        let urlSession = URLSession(configuration: config)

        let task = urlSession.dataTask(with: GameRepo().getDetails(gameId: gameId)) { data, response, _ in
            guard let response = response as? HTTPURLResponse else { return }

            let statusCode = response.statusCode

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            if let data = data {
                if statusCode == 200 {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.dateDecodingStrategy = .formatted(formatter)

                    do {
                        let game = try decoder.decode(GameDetail.self, from: data)

                        completion(.success(game))
                    } catch {
                        completion(.failure(DataError.custom(code: -5,
                                                             message: "Failure when attempting to decode the data.")))
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
}
