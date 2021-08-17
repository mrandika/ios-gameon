//
//  GameRepo.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import Foundation

class GameRepo {
    let baseUrl = "https://api.rawg.io/api/games"
    
    // Replace this example API Key
    // Get at https://rawg.io/apidocs
    let apiKey = "bd68d1483c8d428ab66fbd4edda44571"

    let pageSize = 10

    private func base(usePaging: Bool = true,
                      page: Int? = 1,
                      pageSize: Int = 10,
                      useOrdering: Bool = false,
                      ordering: String? = nil) -> URLComponents {
        var components = URLComponents(string: baseUrl)!

        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: String(pageSize))
        ]

        if usePaging {
            components.queryItems?.append(URLQueryItem(name: "page", value: String(page ?? 1)))
        }

        if useOrdering {
            components.queryItems?.append(URLQueryItem(name: "ordering", value: ordering))
        }

        return components
    }

    func getNewlyReleased(page: Int) -> URL {
        return base(usePaging: true, page: page, useOrdering: true, ordering: "released").url!
    }

    func getTopRated(page: Int) -> URL {
        return base(usePaging: true, page: page, useOrdering: false).url!
    }

    func getPlatformBased(platform: Int) -> URL {
        var componentUrl = base(usePaging: false, pageSize: 5, useOrdering: false)
        componentUrl.queryItems?.append(URLQueryItem(name: "platforms", value: String(platform)))

        return componentUrl.url!
    }

    func getDiscovery(page: Int) -> URL {
        return base(usePaging: true, page: page, useOrdering: true, ordering: "-metacritic").url!
    }

    func getSearchQuery(query: String, page: Int) -> URL {
        var componentUrl = base(usePaging: true, page: page, pageSize: pageSize)
        componentUrl.queryItems?.append(URLQueryItem(name: "search",
                                                     value: query.trimmingCharacters(in: .whitespacesAndNewlines)))

        return componentUrl.url!
    }

    func getDetails(gameId: Int) -> URL {
        var components = URLComponents(string: baseUrl + "/\(gameId)")!

        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]

        return components.url!
    }
}
