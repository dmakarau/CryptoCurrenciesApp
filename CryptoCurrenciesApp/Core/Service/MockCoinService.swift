//
//  MockCoinService.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 03.11.25.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    
    var mockData: Data?
    var mockError: CoinAPIError?
    
    func fetchCoins() async throws -> [Coin] {
        if let mockError { throw mockError }
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockData ?? mockCoinsData_marketCapDesc)
            return coins
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        return nil
    }
    
    
}
