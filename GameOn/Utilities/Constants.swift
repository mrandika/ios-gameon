//
//  Constants.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import Foundation

enum TabItems {
    case newReleases
    case topRated
    case platforms
    case favorites
    case search
}

enum HttpError: Error {
    case redirection(code: Int, message: String)
    case clientError(code: Int, message: String)
    case serverError(code: Int, message: String)
    case custom(code: Int, message: String)
}

enum DataError: Error {
    case decodingFail(code: Int, message: String)
    case encodingFail(code: Int, message: String)
    case localStorageFail(code: Int, message: String)
    case custom(code: Int, message: String)
}
