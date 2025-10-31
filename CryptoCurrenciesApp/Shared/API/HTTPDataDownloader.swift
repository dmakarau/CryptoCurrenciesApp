//
//  HTTPDataDownloader.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 31.10.25.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw CoinAPIError.requestFailed(description: "Invalid URL")
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Bad response")
        }
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(code: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
            
        } catch {
            print("DEBUG-> Error fetching coins: \(error)")
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}
