//
//  CoinDetailsViewModel.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 29.10.25.
//

import Foundation

@Observable
final class CoinDetailsViewModel {
    var coinDetails: CoinDetails?
    private let service = CoinDataService()
    private let coinId: String
    
    init(coinId: String) {
        self.coinId = coinId
    }
    
    func fetchCoinDetails(for coinID: String) async {
        do {
            let details =  try await service.fetchCoinDetails(id: coinID)
            self.coinDetails = details
        } catch {
            print("DEBUG: Failed to fetch coin details: \(error)")
        }
    }
}

