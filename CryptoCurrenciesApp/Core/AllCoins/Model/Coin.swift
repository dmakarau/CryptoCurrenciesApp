//
//  Coin.swift
//  CryptoCurrenciesApp
//
//  Created by Denis Makarau on 24.10.25.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
//    let currentPrice: Double
//    let marketCapRank: Int
    
}
