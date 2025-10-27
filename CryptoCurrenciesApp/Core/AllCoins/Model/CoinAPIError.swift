//
//  CoinAPIError.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 27.10.25.
//

import Foundation
enum CoinAPIError: Error, LocalizedError {
    case invalidData
    case jsonParsingError
    case requestFailed(description: String)
    case invalidStatusCode(code: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "The data received from the server is invalid."
        case .jsonParsingError:
            return "Failed to parse the JSON data."
        case .requestFailed(let description):
            return "Request failed: \(description)"
        case .invalidStatusCode(let code):
            return "Invalid status code received: \(code)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
