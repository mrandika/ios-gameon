//
//  PlatformRepo.swift
//  GameOn
//
//  Created by Andika on 13/08/21.
//

import Foundation

class PlatformRepo {
    let baseUrl = "https://api.rawg.io/api/platforms"
    let apiKey = "bd68d1483c8d428ab66fbd4edda44571"

    func getAllPlatform() -> URL {
        var components = URLComponents(string: baseUrl)!

        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: String(20))
        ]

        return components.url!
    }
}
